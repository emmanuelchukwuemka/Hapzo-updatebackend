"""
Chat WS CONSUMER INIT
"""

from apps.infrastructure.calls.ws_consumer.discover_consumer import DiscoverConsumer
from apps.infrastructure.calls.ws_consumer.livestream_consumer import LiveStreamConsumer
from apps.infrastructure.calls.ws_consumer.webrtc_consumer import WebRTCConsumer
from apps.infrastructure.calls.ws_consumer.webrtc_notify_consumer import (
    WebRTCNotifyConsumer,
)
