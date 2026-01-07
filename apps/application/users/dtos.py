from dataclasses import dataclass
from datetime import date, datetime
from typing import Dict, List


@dataclass
class CreateUserDTO:
    email: str
    username: str
    password: str
    password_confirm: str


@dataclass
class UserDetailDTO:
    id: str
    username: str | None = None


@dataclass
class UserResponseDTO(UserDetailDTO):
    email: str | None = None
    is_email_verified: bool = False
    follower_count: int | None = None
    following_count: int | None = None
    mention_count: int | None = None
    profile_picture: str | None = None
    created_at: datetime | None = None
    updated_at: datetime | None = None


@dataclass
class UserProfileDetailDTO:
    user_id: str
    birth_date: date | None = None
    ethnicity: str | None = None
    relationship_status: str | None = None
    first_name: str | None = None
    last_name: str | None = None
    bio: str | None = None
    occupation: str | None = None
    profile_picture: str | None = None
    location: str | None = None
    height: float | None = None
    weight: float | None = None


@dataclass
class UserProfileResponseDTO(UserProfileDetailDTO):
    id: str | None = None
    post_count: int = 0
    follower_count: int = 0
    following_count: int = 0
    created_at: datetime | None = None
    updated_at: datetime | None = None


@dataclass
class UserProfileListDTO:
    page: int
    page_size: int


@dataclass
class PaginatedUserProfileListResponseDTO:
    result: List[UserProfileResponseDTO]
    previous_profiles_data: str | None = None
    next_profiles_data: str | None = None


@dataclass
class FollowRequestDTO:
    requester_id: str
    target_id: str


@dataclass
class FollowRequestResponseDTO:
    id: str
    requester_id: str
    target_id: str
    created_at: datetime


@dataclass
class FriendsListDTO:
    user_id: str
    page: int
    page_size: int


@dataclass
class PaginatedFriendsListResponseDTO:
    friends: List[UserProfileResponseDTO]
    previous_friends_data: str | None = None
    next_friends_data: str | None = None


@dataclass
class UserFollowersDTO:
    user_id: str
    page: int
    page_size: int


@dataclass
class UserFollowingsDTO:
    user_id: str
    page: int
    page_size: int


@dataclass
class PaginatedFollowersResponseDTO:
    followers: List[UserProfileResponseDTO]
    previous_followers_data: str | None = None
    next_followers_data: str | None = None


@dataclass
class PaginatedFollowingsResponseDTO:
    followings: List[UserProfileResponseDTO]
    previous_followings_data: str | None = None
    next_followings_data: str | None = None


@dataclass
class UserSearchDTO:
    query: str
    offset: int = 10
    limit: int = 1000


@dataclass
class FriendSearchDTO:
    user_id: str
    query: str
    offset: int = 10
    limit: int = 1000


@dataclass
class SearchResponseDTO:
    users: List[Dict[str, str]]
    previous_search_data: str | None = None
    next_search_data: str | None = None
