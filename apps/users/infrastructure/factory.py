from ...users.application.rules import (
    CreateUserProfileRule,
    FetchUserProfileRule,
    FetchUserRule,
    FollowUserRule,
    UpdateUserRule,
    UserProfileListRule,
)
from ...users.infrastructure.repositories import (
    DjangoUserFollowingRepository,
    DjangoUserProfileRepository,
    DjangoUserRepository,
)


def get_user_repository() -> DjangoUserRepository:
    return DjangoUserRepository()


def get_user_profile_repository() -> DjangoUserProfileRepository:
    return DjangoUserProfileRepository()


def get_user_following_repository() -> DjangoUserFollowingRepository:
    return DjangoUserFollowingRepository()


def fetch_user_rule() -> FetchUserRule:
    return FetchUserRule(user_repository=get_user_repository())


def create_user_profile_rule() -> CreateUserProfileRule:
    return CreateUserProfileRule(user_profile_repository=get_user_profile_repository())


def fetch_user_profile_rule() -> FetchUserProfileRule:
    return FetchUserProfileRule(user_profile_repository=get_user_profile_repository())


def user_profile_list_rule() -> UserProfileListRule:
    return UserProfileListRule(user_profile_repository=get_user_profile_repository())


def update_user_rule() -> UpdateUserRule:
    return UpdateUserRule(user_repository=get_user_repository())


def follow_user_rule() -> FollowUserRule:
    return FollowUserRule(
        user_profile_repository=get_user_profile_repository(),
        user_following_repository=get_user_following_repository(),
    )
