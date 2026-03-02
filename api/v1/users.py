from django.urls import path

from apps.presentation.views.users import (
    create_user_profile,
    handle_follow_request,
    list_pending_follow_requests,
    search_users,
    fetch_profiles_list,
    fetch_user,
    fetch_user_profile,
    get_friends_list,
    get_user_followers,
    get_user_followings,
    search_friends,
    send_follow_request,
    unfollow_user,
    update_user,
    update_user_profile,
)

urlpatterns = [
    path("", fetch_user, name="fetch-user"),
    path(
        "search/",
        search_users,
        name="search-users",
    ),
    path("update/", update_user, name="update-user"),
    path("profile/create/", create_user_profile, name="create-user-profile"),
    path("profile/update/", update_user_profile, name="update-user-profile"),
    path("profile/<str:user_id>/", fetch_user_profile, name="fetch-user-profile"),
    path(
        "profiles/<int:page>/<int:page_size>/",
        fetch_profiles_list,
        name="fetch-profiles-list",
    ),
    path(
        "follow-request/<str:user_id>/", send_follow_request, name="send-follow-request"
    ),
    path(
        "follow-request/handle/<str:request_id>/",
        handle_follow_request,
        name="handle-follow-request",
    ),
    path(
        "follow-requests/pending/<int:page>/<int:page_size>/",
        list_pending_follow_requests,
        name="list-pending-follow-requests",
    ),
    path(
        "unfollow/<str:user_id>/",
        unfollow_user,
        name="unfollow-user",
    ),
    path(
        "friends/<int:page>/<int:page_size>/", get_friends_list, name="get-friends-list"
    ),
    path("friends/search/", search_friends, name="search-friends"),
    path(
        "followers/<str:user_id>/<int:page>/<int:page_size>/",
        get_user_followers,
        name="get-user-followers",
    ),
    path(
        "followings/<str:user_id>/<int:page>/<int:page_size>/",
        get_user_followings,
        name="get-user-followings",
    ),
]
