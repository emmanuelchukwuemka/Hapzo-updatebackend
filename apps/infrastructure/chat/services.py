from asgiref.sync import async_to_sync
from channels.layers import get_channel_layer
from loguru import logger

from apps.application.chat.ports import ChatWebSocketServiceInterface


class ChannelsChatService(ChatWebSocketServiceInterface):
    def __init__(self):
        self.channel_layer = get_channel_layer()

    def send_message_to_conversation(
        self, conversation_id: str, message_data: dict
    ) -> None:
        if not self.channel_layer:
            logger.error("Channel layer not configured")
            return

        group_name = self.get_conversation_channel(conversation_id)

        try:
            async_to_sync(self.channel_layer.group_send)(
                group_name,
                {
                    "type": "chat_message",
                    "id": message_data.get("id"),
                    "conversation_id": conversation_id,
                    "sender_id": message_data.get("sender_id"),
                    "message_content_type": message_data.get("message_type"),
                    "text_content": message_data.get("text_content"),
                    "media_url": message_data.get("media_url"),
                    "is_reply": message_data.get("is_reply"),
                    "previous_message_id": message_data.get("previous_message_id"),
                    "previous_message_content": message_data.get(
                        "previous_message_content"
                    ),
                    "previous_message_sender_id": message_data.get(
                        "previous_message_sender_id"
                    ),
                    "created_at": (
                        message_data.get("created_at").isoformat()
                        if message_data.get("created_at")
                        else None
                    ),
                    "status": message_data.get("status", "sent"),
                },
            )
            logger.info(f"Message sent to conversation {conversation_id}")
        except Exception as e:
            logger.error(
                f"Failed to send message to conversation {conversation_id}: {e}"
            )

    def get_conversation_channel(self, conversation_id: str) -> str:
        return f"chat_{conversation_id}"
