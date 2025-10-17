import os
import uuid
from datetime import datetime
from typing import Any

from django.conf import settings
from django.core.files.storage import default_storage
from django.core.files.uploadedfile import UploadedFile
from loguru import logger


def generate_unique_filename(original_filename: str, user_id: str) -> str:
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    unique_id = uuid.uuid4().hex[:8]
    name, ext = os.path.splitext(original_filename)

    safe_name = "".join(c for c in name if c.isalnum() or c in (" ", "-", "_"))[:50]

    return f"{user_id}_{timestamp}_{unique_id}_{safe_name}{ext}"


def get_upload_path(message_type: str, filename: str) -> str:
    now = datetime.now()
    year = now.strftime("%Y")
    month = now.strftime("%m")

    type_dir = f"{message_type}s" if not message_type.endswith("s") else message_type

    return os.path.join("chat", type_dir, year, month, filename)


def save_chat_media(file: UploadedFile, message_type: str, user_id: str) -> str:
    try:
        unique_filename = generate_unique_filename(file.name, user_id)

        upload_path = get_upload_path(message_type, unique_filename)

        saved_path = default_storage.save(upload_path, file)

        file_url = default_storage.url(saved_path)

        if not file_url.startswith(("http://", "https://")):
            backend_domain = settings.BACKEND_DOMAIN
            file_url = f"{backend_domain}/{file_url}"

        logger.info(f"Media uploaded successfully: {saved_path} for user {user_id}")

        return file_url

    except Exception as e:
        logger.error(f"Failed to save media file: {e}")
        raise Exception(f"Failed to upload media: {str(e)}")
