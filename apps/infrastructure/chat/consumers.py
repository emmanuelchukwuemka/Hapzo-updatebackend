import json
from typing import Any, Dict

from channels.db import database_sync_to_async
from channels.generic.websocket import AsyncWebsocketConsumer
from loguru import logger

from apps.infrastructure.chat.repositories import (
    DjangoConversationParticipantRepository,
)


class ChatConsumer(AsyncWebsocketConsumer):
    """
    WebSocket consumer for handling real-time chat messages.

    Connection URL: ws://domain/ws/chat/{conversation_id}/

    Message Types:
    - message: Send a chat message
    - typing: Send typing indicator
    - read: Mark messages as read
    """

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.conversation_id = None
        self.conversation_group_name = None
        self.user = None
        self.participant_repo = DjangoConversationParticipantRepository()

    async def connect(self):
        self.user = self.scope["user"]
        self.conversation_id = self.scope["url_route"]["kwargs"]["conversation_id"]
        self.conversation_group_name = f"chat_{self.conversation_id}"

        if not self.user.is_authenticated:
            logger.warning("Unauthenticated user tried to connect to chat")
            await self.close()
            return

        is_participant = await self.check_participant()
        if not is_participant:
            logger.warning(
                f"User {self.user.id} tried to connect to conversation {self.conversation_id} without permission"
            )
            await self.close()
            return

        await self.channel_layer.group_add(
            self.conversation_group_name, self.channel_name
        )

        await self.accept()
        logger.info(
            f"User {self.user.id} connected to conversation {self.conversation_id}"
        )

        await self.send(
            text_data=json.dumps(
                {
                    "type": "connection_established",
                    "message": "Connected to conversation",
                    "conversation_id": self.conversation_id,
                }
            )
        )

    async def disconnect(self, close_code):
        if self.conversation_group_name:
            await self.channel_layer.group_discard(
                self.conversation_group_name, self.channel_name
            )
            logger.info(
                f"User {self.user.id if self.user else 'Unknown'} disconnected from conversation {self.conversation_id}"
            )

    async def receive(self, text_data):
        try:
            data = json.loads(text_data)
            message_type = data.get("type")

            if message_type == "ping":
                await self.send(text_data=json.dumps({"type": "pong"}))
                return

            if message_type == "typing":
                await self.handle_typing_indicator(data)
            elif message_type == "read":
                await self.handle_read_receipt(data)
            else:
                logger.warning(f"Unknown message type: {message_type}")

        except json.JSONDecodeError:
            logger.error("Invalid JSON received")
            await self.send(
                text_data=json.dumps({"type": "error", "message": "Invalid JSON"})
            )
        except Exception as e:
            logger.error(f"Error processing message: {e}")
            await self.send(
                text_data=json.dumps(
                    {"type": "error", "message": "Error processing message"}
                )
            )

    async def handle_typing_indicator(self, data: Dict[str, Any]):
        is_typing = data.get("is_typing", False)

        await self.channel_layer.group_send(
            self.conversation_group_name,
            {
                "type": "typing_indicator",
                "user_id": str(self.user.id),
                "username": self.user.username,
                "is_typing": is_typing,
            },
        )

    async def handle_read_receipt(self, data: Dict[str, Any]):
        message_ids = data.get("message_ids", [])

        await self.channel_layer.group_send(
            self.conversation_group_name,
            {
                "type": "read_receipt",
                "user_id": str(self.user.id),
                "message_ids": message_ids,
            },
        )

    async def chat_message(self, event):
        if event.get("sender_id") != str(self.user.id):
            await self.send(text_data=json.dumps(event))

    async def typing_indicator(self, event):
        if event.get("user_id") != str(self.user.id):
            await self.send(text_data=json.dumps(event))

    async def read_receipt(self, event):
        if event.get("user_id") != str(self.user.id):
            await self.send(text_data=json.dumps(event))

    @database_sync_to_async
    def check_participant(self) -> bool:
        return self.participant_repo.is_participant(
            self.conversation_id, str(self.user.id)
        )
