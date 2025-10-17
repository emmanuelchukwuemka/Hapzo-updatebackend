from rest_framework import serializers

from apps.domain.chat.enums import MessageType


class CreateConversationSerializer(serializers.Serializer):
    participant_ids = serializers.ListField(
        child=serializers.CharField(), required=True, min_length=2, max_length=2
    )
    conversation_type = serializers.CharField(default="private", read_only=True)

    def validate_participant_ids(self, value):
        """Ensure exactly 2 participants for private conversations"""
        if len(value) != 2:
            raise serializers.ValidationError(
                "Private conversations must have exactly 2 participants"
            )
        if value[0] == value[1]:
            raise serializers.ValidationError(
                "Cannot create conversation with yourself"
            )
        return value


class SendMessageSerializer(serializers.Serializer):
    message_type = serializers.ChoiceField(choices=MessageType.choices(), required=True)
    text_content = serializers.CharField(
        required=False, allow_blank=True, max_length=5000
    )
    media_url = serializers.URLField(required=False, allow_blank=True, max_length=500)
    conversation_id = serializers.CharField(read_only=True)
    sender_id = serializers.CharField(read_only=True)
    is_reply = serializers.BooleanField(default=False)
    previous_message_id = serializers.CharField(
        read_only=True, required=False, allow_blank=True, max_length=21
    )

    def validate(self, attrs):
        message_type = attrs.get("message_type")
        text_content = attrs.get("text_content")
        media_url = attrs.get("media_url")

        if message_type == "text" and not text_content:
            raise serializers.ValidationError(
                {"text_content": "Text messages must have content"}
            )

        if message_type in ["image", "audio", "video"] and not media_url:
            raise serializers.ValidationError(
                {"media_url": f"{message_type} messages must have media_url"}
            )

        if attrs.get("is_reply") and not attrs.get("previous_message_id"):
            raise serializers.ValidationError(
                {
                    "previous_message_id": "Previous message id required for reply messages"
                }
            )

        attrs["conversation_id"] = self.context.get("conversation_id")
        attrs["sender_id"] = self.context.get("sender_id")
        return attrs


class ConversationMessagesSerializer(serializers.Serializer):
    conversation_id = serializers.CharField(read_only=True)
    user_id = serializers.CharField(read_only=True)
    page = serializers.IntegerField(required=True, min_value=1)
    page_size = serializers.IntegerField(required=True, min_value=1, max_value=100)

    def validate(self, attrs):
        attrs["conversation_id"] = self.context.get("conversation_id")
        attrs["user_id"] = self.context.get("user_id")
        return attrs


class ConversationListSerializer(serializers.Serializer):
    user_id = serializers.CharField(read_only=True)
    page = serializers.IntegerField(required=True, min_value=1)
    page_size = serializers.IntegerField(required=True, min_value=1, max_value=50)

    def validate(self, attrs):
        attrs["user_id"] = self.context.get("user_id")
        return attrs


class MarkMessagesReadSerializer(serializers.Serializer):
    message_ids = serializers.ListField(
        child=serializers.CharField(), required=False, allow_empty=True
    )
    conversation_id = serializers.CharField(read_only=True)
    user_id = serializers.CharField(read_only=True)

    def validate(self, attrs):
        attrs["conversation_id"] = self.context.get("conversation_id")
        attrs["user_id"] = self.context.get("user_id")
        return attrs


class MediaUploadSerializer(serializers.Serializer):
    """Serializer for media file uploads"""

    file = serializers.FileField(required=True)
    message_type = serializers.ChoiceField(
        choices=["image", "audio", "video"], required=True
    )

    def validate_file(self, value):
        """Validate file size and type"""
        max_size = 50 * 1024 * 1024  # 50MB

        if value.size > max_size:
            raise serializers.ValidationError(
                f"File size cannot exceed {max_size / (1024 * 1024)}MB"
            )

        return value

    def validate(self, attrs):
        file = attrs.get("file")
        message_type = attrs.get("message_type")

        if message_type == "image":
            allowed_types = ["image/jpeg", "image/png", "image/gif", "image/webp"]
            if file.content_type not in allowed_types:
                raise serializers.ValidationError({"file": "Invalid image file type"})

        elif message_type == "audio":
            allowed_types = [
                "audio/mpeg",
                "audio/wav",
                "audio/ogg",
                "audio/mp3",
                "audio/aac",
            ]
            if file.content_type not in allowed_types:
                raise serializers.ValidationError({"file": "Invalid audio file type"})

        elif message_type == "video":
            allowed_types = ["video/mp4", "video/webm", "video/quicktime"]
            if file.content_type not in allowed_types:
                raise serializers.ValidationError({"file": "Invalid video file type"})

        return attrs
