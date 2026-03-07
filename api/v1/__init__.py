from django.urls import include, path
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status


@api_view(['GET'])
def api_root(request):
    """Root API endpoint that returns available endpoints."""
    return Response({
        "status": "ok",
        "message": "Hapzo Backend API v1",
        "endpoints": {
            "users": "/api/v1/users/",
            "authentication": "/api/v1/authentication/",
            "posts": "/api/v1/posts/",
            "notifications": "/api/v1/notifications/",
            "calls": "/api/v1/calls/",
            "chat": "/api/v1/chat/",
            "docs": "/docs/swagger-ui/",
        }
    }, status=status.HTTP_200_OK)


urlpatterns = [
    path("", api_root, name="api-root"),
    path("users/", include("api.v1.users")),
    path("authentication/", include("api.v1.authentication")),
    path("posts/", include("api.v1.posts")),
    path("notifications/", include("api.v1.notifications")),
    path("calls/", include("api.v1.calls")),
    path("chat/", include("api.v1.chat")),
]
