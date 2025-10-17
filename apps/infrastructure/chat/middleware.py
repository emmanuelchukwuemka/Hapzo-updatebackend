from channels.db import database_sync_to_async
from channels.middleware import BaseMiddleware
from django.contrib.auth.models import AnonymousUser
from knox import crypto
from knox.models import AuthToken
from loguru import logger


@database_sync_to_async
def get_user_from_token(token_key):
    try:
        digest = crypto.hash_token(token_key)
        auth_token = AuthToken.objects.select_related("user").get(digest=digest)
        return auth_token.user
    except AuthToken.DoesNotExist:
        return AnonymousUser()


class TokenAuthMiddleware(BaseMiddleware):
    """
    Custom middleware to authenticate WebSocket connections using Knox tokens.

    Token can be passed as:
    - Query parameter: ?token=<token>
    - Header: Authorization: Bearer <token>
    """

    async def __call__(self, scope, receive, send):
        query_string = scope.get("query_string", b"").decode()
        token = None

        if "token=" in query_string:
            try:
                token = query_string.split("token=")[1].split("&")[0]
            except IndexError:
                pass

        if not token:
            headers = dict(scope.get("headers", []))
            auth_header = headers.get(b"authorization", b"").decode()
            if auth_header.startswith("Bearer "):
                token = auth_header.split("Bearer ")[1]

        if token:
            scope["user"] = await get_user_from_token(token)
        else:
            scope["user"] = AnonymousUser()
            logger.warning("WebSocket connection attempt without token")

        return await super().__call__(scope, receive, send)
