from django.urls import path

from apps.users.presentation.views import (
    create_user_profile,
    fetch_profiles_list,
    fetch_user,
    fetch_user_profile,
    follow_user,
    update_user,
)

urlpatterns = [
    path("", fetch_user, name="fetch-user"),
    path("update/", update_user, name="update-user"),
    path("profile/create/", create_user_profile, name="create-user-profile"),
    path("profile/<str:user_id>/", fetch_user_profile, name="fetch-user-profile"),
    path(
        "profiles/<int:page>/<int:page_size>/",
        fetch_profiles_list,
        name="fetch-profiles-list",
    ),
    path("follow/<str:user_id>/", follow_user, name="follow-user"),
]
