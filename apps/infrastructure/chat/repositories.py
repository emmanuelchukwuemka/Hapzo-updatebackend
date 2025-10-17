from datetime import UTC, datetime
from typing import Any, Dict, List, Tuple

from django.db.models import Count
from django.urls import reverse

from apps.application.chat.ports import (
    ConversationParticipantRepositoryInterface,
    ConversationRepositoryInterface,
    MessageRepositoryInterface,
)
from apps.domain.chat.entities import (
    Conversation as DomainConversation,
)
from apps.domain.chat.entities import (
    ConversationParticipant as DomainConversationParticipant,
)
from apps.domain.chat.entities import Message as DomainMessage

from .models.tables import Conversation, ConversationParticipant, Message


def to_domain_conversation(django_conversation: Conversation) -> DomainConversation:
    participant_ids = list(
        django_conversation.participants.values_list("user_id", flat=True)
    )
    return DomainConversation(
        id=django_conversation.id,
        conversation_type=django_conversation.conversation_type,
        participant_ids=participant_ids,
        created_at=django_conversation.created_at,
        updated_at=django_conversation.updated_at,
        last_message_at=django_conversation.last_message_at,
    )


def from_domain_conversation(domain_conversation: DomainConversation) -> Dict[str, Any]:
    return {
        "conversation_type": domain_conversation.conversation_type,
    }


def to_domain_participant(
    django_participant: ConversationParticipant,
) -> DomainConversationParticipant:
    return DomainConversationParticipant(
        id=django_participant.id,
        conversation_id=django_participant.conversation_id,
        user_id=django_participant.user_id,
        joined_at=django_participant.joined_at,
        last_read_at=django_participant.last_read_at,
    )


def to_domain_message(django_message: Message) -> DomainMessage:
    return DomainMessage(
        id=django_message.id,
        conversation_id=django_message.conversation_id,
        sender_id=django_message.sender_id,
        message_type=django_message.message_type,
        text_content=django_message.text_content,
        media_url=django_message.media_url,
        is_reply=django_message.is_reply,
        previous_message_content=django_message.previous_message_content,
        previous_message_id=django_message.previous_message_id,
        previous_message_sender_id=django_message.previous_message_sender_id,
        status=django_message.status,
        created_at=django_message.created_at,
        updated_at=django_message.updated_at,
        read_at=django_message.read_at,
    )


def from_domain_message(domain_message: DomainMessage) -> Dict[str, Any]:
    return {
        "conversation_id": domain_message.conversation_id,
        "sender_id": domain_message.sender_id,
        "message_type": domain_message.message_type,
        "text_content": domain_message.text_content,
        "media_url": domain_message.media_url,
        "is_reply": domain_message.is_reply,
        "previous_message_content": domain_message.previous_message_content,
        "previous_message_id": domain_message.previous_message_id,
        "previous_message_sender_id": domain_message.previous_message_sender_id,
        "status": domain_message.status,
    }


class DjangoConversationRepository(ConversationRepositoryInterface):
    def create(self, conversation: DomainConversation) -> DomainConversation:
        django_conversation_data = from_domain_conversation(conversation)
        created_conversation = Conversation.objects.create(**django_conversation_data)
        return to_domain_conversation(created_conversation)

    def find_by_id(self, conversation_id: str) -> DomainConversation | None:
        try:
            django_conversation = Conversation.objects.prefetch_related(
                "participants"
            ).get(id=conversation_id)
            return to_domain_conversation(django_conversation)
        except Conversation.DoesNotExist:
            return None

    def find_private_conversation(
        self, user1_id: str, user2_id: str
    ) -> DomainConversation | None:
        conversations = (
            Conversation.objects.filter(
                conversation_type="private",
                participants__user_id__in=[user1_id, user2_id],
            )
            .annotate(participant_count=Count("participants"))
            .filter(participant_count=2)
        )

        for conversation in conversations:
            participant_ids = set(
                conversation.participants.values_list("user_id", flat=True)
            )
            if participant_ids == {user1_id, user2_id}:
                return to_domain_conversation(conversation)

        return None

    def get_user_conversations(
        self, user_id: str, page: int, page_size: int
    ) -> Tuple[List[Any], str | None, str | None]:
        queryset = (
            Conversation.objects.filter(participants__user_id=user_id)
            .prefetch_related("participants")
            .order_by("-last_message_at", "-created_at")
        )

        total_conversations = queryset.count()
        offset = (page - 1) * page_size
        end = offset + page_size

        conversations = [to_domain_conversation(conv) for conv in queryset[offset:end]]

        previous_link = None
        if page > 1:
            previous_link = reverse(
                "get-conversations", kwargs={"page": page - 1, "page_size": page_size}
            )

        next_link = None
        if end < total_conversations:
            next_link = reverse(
                "get-conversations", kwargs={"page": page + 1, "page_size": page_size}
            )

        return conversations, previous_link, next_link

    def update_last_message_time(self, conversation_id: str) -> None:
        Conversation.objects.filter(id=conversation_id).update(
            last_message_at=datetime.now(UTC)
        )


class DjangoConversationParticipantRepository(
    ConversationParticipantRepositoryInterface
):
    def add_participants(
        self, participants: List[DomainConversationParticipant]
    ) -> List[DomainConversationParticipant]:
        django_participants = [
            ConversationParticipant(
                conversation_id=p.conversation_id,
                user_id=p.user_id,
            )
            for p in participants
        ]
        created = ConversationParticipant.objects.bulk_create(django_participants)
        return [to_domain_participant(p) for p in created]

    def is_participant(self, conversation_id: str, user_id: str) -> bool:
        return ConversationParticipant.objects.filter(
            conversation_id=conversation_id, user_id=user_id
        ).exists()

    def get_participants(self, conversation_id: str) -> List[str]:
        return list(
            ConversationParticipant.objects.filter(
                conversation_id=conversation_id
            ).values_list("user_id", flat=True)
        )

    def update_last_read(self, conversation_id: str, user_id: str) -> None:
        ConversationParticipant.objects.filter(
            conversation_id=conversation_id, user_id=user_id
        ).update(last_read_at=datetime.now(UTC))


class DjangoMessageRepository(MessageRepositoryInterface):
    def create(self, message: DomainMessage) -> DomainMessage:
        django_message_data = from_domain_message(message)
        created_message = Message.objects.create(**django_message_data)
        return to_domain_message(created_message)

    def find_by_id(self, message_id: str) -> DomainMessage | None:
        try:
            django_message = Message.objects.get(id=message_id)
            return to_domain_message(django_message)
        except Message.DoesNotExist:
            return None

    def get_conversation_messages(
        self, conversation_id: str, page: int, page_size: int
    ) -> Tuple[List[Any], str | None, str | None, int]:
        queryset = Message.objects.filter(conversation_id=conversation_id).order_by(
            "-created_at"
        )

        total_messages = queryset.count()
        offset = (page - 1) * page_size
        end = offset + page_size

        messages = [to_domain_message(msg) for msg in queryset[offset:end]]

        previous_link = None
        if page > 1:
            previous_link = reverse(
                "get-conversation-messages",
                kwargs={
                    "conversation_id": conversation_id,
                    "page": page - 1,
                    "page_size": page_size,
                },
            )

        next_link = None
        if end < total_messages:
            next_link = reverse(
                "get-conversation-messages",
                kwargs={
                    "conversation_id": conversation_id,
                    "page": page + 1,
                    "page_size": page_size,
                },
            )

        return messages, previous_link, next_link, total_messages

    def mark_as_read(
        self, conversation_id: str, user_id: str, message_ids: List[str] | None = None
    ) -> None:
        queryset = Message.objects.filter(conversation_id=conversation_id).exclude(
            sender_id=user_id
        )

        if message_ids:
            queryset = queryset.filter(id__in=message_ids)

        queryset.update(status="read", read_at=datetime.now(UTC))

    def get_unread_count(self, conversation_id: str, user_id: str) -> int:
        return (
            Message.objects.filter(
                conversation_id=conversation_id, status__in=["sent", "delivered"]
            )
            .exclude(sender_id=user_id)
            .count()
        )

    def get_last_message(self, conversation_id: str) -> DomainMessage | None:
        try:
            last_message = Message.objects.filter(
                conversation_id=conversation_id
            ).latest("created_at")
            return to_domain_message(last_message)
        except Message.DoesNotExist:
            return None
