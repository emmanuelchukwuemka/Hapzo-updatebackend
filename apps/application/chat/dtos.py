from dataclasses import dataclass
from datetime import datetime
from typing import Any, Dict, List


@dataclass
class CreateConversationDTO:
    participant_ids: List[str]
    conversation_type: str = "private"


@dataclass
class ConversationResponseDTO:
    id: str
    conversation_type: str
    participant_ids: List[str]
    created_at: datetime
    updated_at: datetime
    last_message_at: datetime | None = None
    last_message: Dict[str, Any] | None = None
    unread_count: int = 0


@dataclass
class SendMessageDTO:
    conversation_id: str
    sender_id: str
    message_type: str
    text_content: str | None = None
    media_url: str | None = None
    is_reply: bool = False
    previous_message_id: str | None = None


@dataclass
class MessageResponseDTO:
    id: str
    conversation_id: str
    sender_id: str
    message_type: str
    text_content: str | None
    media_url: str | None
    status: str
    created_at: datetime
    updated_at: datetime
    is_reply: bool = False
    previous_message_content: str | None = None
    previous_message_id: str | None = None
    previous_message_sender_id: str | None = None
    read_at: datetime | None = None
    sender_username: str | None = None


@dataclass
class ConversationMessagesDTO:
    conversation_id: str
    user_id: str
    page: int = 1
    page_size: int = 50


@dataclass
class PaginatedMessagesResponseDTO:
    messages: List[MessageResponseDTO]
    previous_link: str | None = None
    next_link: str | None = None
    total_count: int = 0


@dataclass
class ConversationListDTO:
    user_id: str
    page: int = 1
    page_size: int = 20


@dataclass
class PaginatedConversationsResponseDTO:
    conversations: List[ConversationResponseDTO]
    previous_link: str | None = None
    next_link: str | None = None


@dataclass
class MarkMessagesReadDTO:
    conversation_id: str
    user_id: str
    message_ids: List[str] | None = None


@dataclass
class TypingIndicatorDTO:
    conversation_id: str
    user_id: str
    is_typing: bool
