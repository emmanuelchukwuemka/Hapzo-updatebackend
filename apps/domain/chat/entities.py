from dataclasses import dataclass, field
from datetime import datetime
from typing import List

from .value_objects import ConversationType, MessageStatus, MessageType


@dataclass
class Conversation:
    conversation_type: str
    participant_ids: List[str] = field(default_factory=list)
    id: str | None = None
    created_at: datetime | None = None
    updated_at: datetime | None = None
    last_message_at: datetime | None = None

    def __post_init__(self) -> None:
        self.conversation_type = ConversationType(self.conversation_type).value


@dataclass
class ConversationParticipant:
    conversation_id: str
    user_id: str
    last_read_at: datetime | None = None
    id: str | None = None
    joined_at: datetime | None = None


@dataclass
class Message:
    conversation_id: str
    sender_id: str
    message_type: str
    text_content: str | None = None
    media_url: str | None = None
    status: str = "sent"
    id: str | None = None
    is_reply: bool = False
    previous_message_content: str | None = None
    previous_message_id: str | None = None
    previous_message_sender_id: str | None = None
    created_at: datetime | None = None
    updated_at: datetime | None = None
    read_at: datetime | None = None

    def __post_init__(self) -> None:
        self.message_type = MessageType(self.message_type).value
        self.status = MessageStatus(self.status).value
