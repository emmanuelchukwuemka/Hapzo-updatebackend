from typing import Any, List, Protocol, Tuple

from apps.domain.chat.entities import Conversation, ConversationParticipant, Message


class ConversationRepositoryInterface(Protocol):
    def get_or_create(self, conversation: Conversation) -> Conversation: ...

    def find_by_id(self, conversation_id: str) -> Conversation | None: ...

    def find_private_conversation(
        self, user1_id: str, user2_id: str
    ) -> Conversation | None: ...

    def get_user_conversations(
        self, user_id: str, page: int, page_size: int
    ) -> Tuple[List[Any], str | None, str | None]: ...

    def update_last_message_time(self, conversation_id: str) -> None: ...


class ConversationParticipantRepositoryInterface(Protocol):
    def add_participants(
        self, participants: List[ConversationParticipant]
    ) -> List[ConversationParticipant]: ...

    def is_participant(self, conversation_id: str, user_id: str) -> bool: ...

    def get_participants(self, conversation_id: str) -> List[str]: ...

    def update_last_read(self, conversation_id: str, user_id: str) -> None: ...


class MessageRepositoryInterface(Protocol):
    def create(self, message: Message) -> Message: ...

    def find_by_id(self, message_id: str) -> Message | None: ...

    def get_conversation_messages(
        self, conversation_id: str, page: int, page_size: int
    ) -> Tuple[List[Any], str | None, str | None, int]: ...

    def mark_as_read(
        self, conversation_id: str, user_id: str, message_ids: List[str] | None = None
    ) -> None: ...

    def get_unread_count(self, conversation_id: str, user_id: str) -> int: ...

    def get_last_message(self, conversation_id: str) -> Message | None: ...


class ChatWebSocketServiceInterface(Protocol):
    def send_message_to_conversation(
        self, conversation_id: str, message_data: dict
    ) -> None: ...

    def send_typing_indicator(
        self, conversation_id: str, user_id: str, is_typing: bool
    ) -> None: ...

    def get_conversation_channel(self, conversation_id: str) -> str: ...
