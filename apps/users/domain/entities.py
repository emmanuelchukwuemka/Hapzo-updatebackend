from dataclasses import dataclass, field
from datetime import UTC, date, datetime
from typing import List

from .value_objects import Ethnicity, RelationshipStatus


@dataclass
class User:
    email: str
    username: str
    hashed_password: str = field(repr=False)
    id: str | None = None
    is_email_verified: bool = False
    is_active: bool = True
    created_at: datetime = field(default_factory=lambda: datetime.now(tz=UTC))
    updated_at: datetime = field(default_factory=lambda: datetime.now(tz=UTC))


@dataclass
class UserProfile:
    user_id: str
    birth_date: date
    ethnicity: str
    relationship_status: str
    id: str | None = None
    first_name: str = ""
    last_name: str = ""
    bio: str = ""
    occupation: str = ""
    profile_picture: str | None = None
    height: float = 0.00
    weight: float = 0.00
    following_ids: List = field(default_factory=list)
    follower_ids: List = field(default_factory=list)
    created_at: datetime = field(default_factory=lambda: datetime.now(tz=UTC))
    updated_at: datetime = field(default_factory=lambda: datetime.now(tz=UTC))

    def __post_init__(self) -> None:
        self.ethnicity = Ethnicity(self.ethnicity).value
        self.relationship_status = RelationshipStatus(self.relationship_status).value


@dataclass
class UserFollowing:
    follower_id: str
    following_id: str
    id: str | None = None
    created_at: datetime = field(default_factory=lambda: datetime.now(tz=UTC))
