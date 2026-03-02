"""
LiveStream WebSocket Consumer
"""

import logging
from datetime import datetime
from typing import Any, Dict

from channels.generic.websocket import AsyncJsonWebsocketConsumer
from channels.db import database_sync_to_async
from django.contrib.auth import get_user_model
from django.contrib.auth.models import AnonymousUser
from django.utils import timezone

from apps.infrastructure.calls.models.livestream_models import (
    LiveStreamModel,
    LiveStreamViewerModel,
)

logger = logging.getLogger(__name__)

User = get_user_model()


CLIENT_EVENT_TYPES = [
    "start_stream",
    "end_stream",
    "send_comment",
    "send_gift",
    "send_reaction",
]

BACKEND_EVENT_TYPES = [
    "stream_started",
    "stream_ended",
    "viewer_joined",
    "viewer_left",
    "new_comment",
    "new_gift",
    "new_reaction",
    "viewer_count_update",
    "error",
]


class LiveStreamConsumer(AsyncJsonWebsocketConsumer):
    """
    LiveStreamConsumer

    Handles all real-time livestream events:
    - Stream lifecycle (start/end)
    - Viewer presence (join/leave)
    - Comments (text/voice)
    - Gifts and reactions
    """

    def __init__(self, *args: object, **kwargs: object) -> None:
        """
        Constructor
        """
        self.user: AnonymousUser | None | User = None
        self.stream_id: str | None = None
        self.stream_group: str | None = None
        self.is_streamer: bool = False
        super().__init__(*args, **kwargs)

    async def connect(self) -> None:
        """
        Handle WebSocket connection with authentication.
        """
        self.user = self.scope.get("user", None)

        if not self.user or isinstance(self.user, AnonymousUser):
            logger.warning("Anonymous user tried to connect to livestream")
            await self.close(code=4001)
            return

        self.stream_id = self.scope["url_route"]["kwargs"].get("stream_id")
        self.stream_group = f"livestream_{self.stream_id}"

        await self.accept()

        # Join the stream channel group
        await self.channel_layer.group_add(self.stream_group, self.channel_name)

        # Check if this user is the streamer
        self.is_streamer = await self._is_stream_owner()

        if not self.is_streamer:
            # Register as viewer
            await self._add_viewer()
            viewer_count = await self._get_viewer_count()

            # Notify the group
            await self.channel_layer.group_send(
                self.stream_group,
                {
                    "type": "viewer_joined",
                    "user_id": str(self.user.id),
                    "username": self.user.username,
                    "viewer_count": viewer_count,
                },
            )

        logger.info(
            f"User {self.user.id} connected to livestream {self.stream_id} "
            f"(streamer={self.is_streamer})"
        )

    async def disconnect(self, code: int) -> None:
        """
        Handle WebSocket disconnection.
        """
        if self.stream_group:
            if not self.is_streamer and self.user:
                await self._remove_viewer()
                viewer_count = await self._get_viewer_count()

                await self.channel_layer.group_send(
                    self.stream_group,
                    {
                        "type": "viewer_left",
                        "user_id": str(self.user.id),
                        "username": getattr(self.user, "username", ""),
                        "viewer_count": viewer_count,
                    },
                )

            await self.channel_layer.group_discard(
                self.stream_group, self.channel_name
            )

        logger.info(
            f"User {getattr(self.user, 'id', 'unknown')} "
            f"disconnected from livestream {self.stream_id}"
        )

    async def receive_json(self, content: Dict[str, Any], **kwargs: Any) -> None:
        """
        Handle incoming WebSocket messages.
        """
        event_type = content.get("type", "")

        if event_type not in CLIENT_EVENT_TYPES:
            await self.send_json(
                {
                    "type": "error",
                    "message": f"Unknown event type: {event_type}",
                }
            )
            return

        handler_map = {
            "start_stream": self._handle_start_stream,
            "end_stream": self._handle_end_stream,
            "send_comment": self._handle_send_comment,
            "send_gift": self._handle_send_gift,
            "send_reaction": self._handle_send_reaction,
        }

        handler = handler_map.get(event_type)
        if handler:
            await handler(content)

    # ─── Event Handlers ───────────────────────────────────────────

    async def _handle_start_stream(self, content: Dict[str, Any]) -> None:
        """
        Streamer starts broadcasting.
        """
        title = content.get("title", "")
        stream = await self._create_stream(title)

        if stream:
            self.is_streamer = True

            await self.channel_layer.group_send(
                self.stream_group,
                {
                    "type": "stream_started",
                    "stream_id": stream.id,
                    "streamer_id": str(self.user.id),
                    "streamer_username": self.user.username,
                    "title": stream.title,
                    "started_at": str(stream.start_time),
                },
            )

            logger.info(f"Stream {stream.id} started by {self.user.id}")
        else:
            await self.send_json(
                {"type": "error", "message": "Failed to start stream."}
            )

    async def _handle_end_stream(self, content: Dict[str, Any]) -> None:
        """
        Streamer ends the stream.
        """
        if not self.is_streamer:
            await self.send_json(
                {"type": "error", "message": "Only the streamer can end the stream."}
            )
            return

        await self._end_stream()

        await self.channel_layer.group_send(
            self.stream_group,
            {
                "type": "stream_ended",
                "stream_id": self.stream_id,
                "ended_at": str(timezone.now()),
            },
        )

        logger.info(f"Stream {self.stream_id} ended by {self.user.id}")

    async def _handle_send_comment(self, content: Dict[str, Any]) -> None:
        """
        Viewer/streamer sends a comment.
        """
        text = content.get("text", "")
        comment_type = content.get("comment_type", "text")  # text or voice

        if not text:
            await self.send_json(
                {"type": "error", "message": "Comment text cannot be empty."}
            )
            return

        await self.channel_layer.group_send(
            self.stream_group,
            {
                "type": "new_comment",
                "user_id": str(self.user.id),
                "username": self.user.username,
                "text": text,
                "comment_type": comment_type,
                "duration": content.get("duration", ""),
                "timestamp": str(timezone.now()),
            },
        )

    async def _handle_send_gift(self, content: Dict[str, Any]) -> None:
        """
        Viewer sends a gift.
        """
        gift_type = content.get("gift_type", "rose")

        await self.channel_layer.group_send(
            self.stream_group,
            {
                "type": "new_gift",
                "user_id": str(self.user.id),
                "username": self.user.username,
                "gift_type": gift_type,
                "timestamp": str(timezone.now()),
            },
        )

    async def _handle_send_reaction(self, content: Dict[str, Any]) -> None:
        """
        Viewer sends an emoji reaction.
        """
        emoji = content.get("emoji", "❤️")

        await self.channel_layer.group_send(
            self.stream_group,
            {
                "type": "new_reaction",
                "user_id": str(self.user.id),
                "username": self.user.username,
                "emoji": emoji,
                "timestamp": str(timezone.now()),
            },
        )

    # ─── Group Message Handlers ───────────────────────────────────

    async def stream_started(self, event: Dict[str, Any]) -> None:
        """
        Broadcast stream started to all connected clients.
        """
        await self.send_json(event)

    async def stream_ended(self, event: Dict[str, Any]) -> None:
        """
        Broadcast stream ended to all connected clients.
        """
        await self.send_json(event)

    async def viewer_joined(self, event: Dict[str, Any]) -> None:
        """
        Broadcast viewer joined to all connected clients.
        """
        await self.send_json(event)

    async def viewer_left(self, event: Dict[str, Any]) -> None:
        """
        Broadcast viewer left to all connected clients.
        """
        await self.send_json(event)

    async def new_comment(self, event: Dict[str, Any]) -> None:
        """
        Broadcast new comment to all connected clients.
        """
        await self.send_json(event)

    async def new_gift(self, event: Dict[str, Any]) -> None:
        """
        Broadcast new gift to all connected clients.
        """
        await self.send_json(event)

    async def new_reaction(self, event: Dict[str, Any]) -> None:
        """
        Broadcast new reaction to all connected clients.
        """
        await self.send_json(event)

    async def viewer_count_update(self, event: Dict[str, Any]) -> None:
        """
        Broadcast viewer count update to all connected clients.
        """
        await self.send_json(event)

    # ─── Database Helpers ─────────────────────────────────────────

    @database_sync_to_async
    def _create_stream(self, title: str) -> LiveStreamModel | None:
        """
        Create a new livestream record.
        """
        try:
            stream = LiveStreamModel.objects.create(
                id=self.stream_id,
                streamer=self.user,
                title=title,
                status=LiveStreamModel.StreamStatus.LIVE,
            )
            return stream
        except Exception as e:
            logger.error(f"Failed to create stream: {e}")
            return None

    @database_sync_to_async
    def _end_stream(self) -> None:
        """
        End the current livestream.
        """
        try:
            LiveStreamModel.objects.filter(id=self.stream_id).update(
                status=LiveStreamModel.StreamStatus.ENDED,
                end_time=timezone.now(),
            )
        except Exception as e:
            logger.error(f"Failed to end stream: {e}")

    @database_sync_to_async
    def _is_stream_owner(self) -> bool:
        """
        Check if the current user is the stream owner.
        """
        try:
            return LiveStreamModel.objects.filter(
                id=self.stream_id, streamer=self.user
            ).exists()
        except Exception:
            return False

    @database_sync_to_async
    def _add_viewer(self) -> None:
        """
        Add the current user as a viewer.
        """
        try:
            LiveStreamViewerModel.objects.get_or_create(
                stream_id=self.stream_id,
                user=self.user,
                defaults={"joined_at": timezone.now()},
            )
            LiveStreamModel.objects.filter(id=self.stream_id).update(
                viewer_count=models.F("viewer_count") + 1
            )
        except Exception as e:
            logger.error(f"Failed to add viewer: {e}")

    @database_sync_to_async
    def _remove_viewer(self) -> None:
        """
        Remove the current user as a viewer.
        """
        try:
            LiveStreamViewerModel.objects.filter(
                stream_id=self.stream_id, user=self.user
            ).update(left_at=timezone.now())

            LiveStreamModel.objects.filter(
                id=self.stream_id, viewer_count__gt=0
            ).update(viewer_count=models.F("viewer_count") - 1)
        except Exception as e:
            logger.error(f"Failed to remove viewer: {e}")

    @database_sync_to_async
    def _get_viewer_count(self) -> int:
        """
        Get the current viewer count.
        """
        try:
            stream = LiveStreamModel.objects.filter(id=self.stream_id).first()
            return stream.viewer_count if stream else 0
        except Exception:
            return 0
