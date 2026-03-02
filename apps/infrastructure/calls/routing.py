"""
Channels WS Routing
"""

from django.urls import re_path

from apps.infrastructure.calls.ws_consumer import (
    WebRTCConsumer,
    WebRTCNotifyConsumer,
    DiscoverConsumer,
    LiveStreamConsumer,
)

websocket_urlpatterns = [
    re_path(r"ws/calls/(?P<call_id>[^/]+)/$", WebRTCConsumer.as_asgi()),  # type: ignore
    re_path(r"ws/notify/$", WebRTCNotifyConsumer.as_asgi()),  # type: ignore
    re_path(r"ws/discover/$", DiscoverConsumer.as_asgi()),  # type: ignore
    re_path(r"ws/livestream/(?P<stream_id>[^/]+)/$", LiveStreamConsumer.as_asgi()),  # type: ignore
]
