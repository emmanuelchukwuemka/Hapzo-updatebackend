from dataclasses import dataclass

from .enums import ConversationType as ConversationTypeEnum
from .enums import MessageStatus as MessageStatusEnum
from .enums import MessageType as MessageTypeEnum


@dataclass(frozen=True)
class MessageType:
    value: str

    def __post_init__(self):
        if not self._is_valid():
            raise ValueError(
                f"Invalid MessageType. Select a value from {MessageTypeEnum.values()}"
            )

    def _is_valid(self) -> bool:
        return self.value in MessageTypeEnum.values()


@dataclass(frozen=True)
class MessageStatus:
    value: str

    def __post_init__(self):
        if not self._is_valid():
            raise ValueError(
                f"Invalid MessageStatus. Select a value from {MessageStatusEnum.values()}"
            )

    def _is_valid(self) -> bool:
        return self.value in MessageStatusEnum.values()


@dataclass(frozen=True)
class ConversationType:
    value: str

    def __post_init__(self):
        if not self._is_valid():
            raise ValueError(
                f"Invalid ConversationType. Select a value from {ConversationTypeEnum.values()}"
            )

    def _is_valid(self) -> bool:
        return self.value in ConversationTypeEnum.values()
