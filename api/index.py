"""
Vercel serverless function handler for Django application.

This uses ASGI with Uvicorn's WSGI-to-ASGI adapter for better serverless compatibility.
"""

import os
import sys
from pathlib import Path

# Setup Python path
BASE_DIR = Path(__file__).resolve().parent.parent
if str(BASE_DIR) not in sys.path:
    sys.path.insert(0, str(BASE_DIR))

# Configure Django before any imports
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "config.settings.production")

import django
from django.core.wsgi import get_wsgi_application

# Setup Django
django.setup()

# Get the WSGI application
wsgi_application = get_wsgi_application()

# Use uvicorn's WsgiToAsgi adapter for Vercel compatibility
try:
    from uvicorn.middleware.wsgi import WSGIMiddleware
    application = WSGIMiddleware(wsgi_application)
except ImportError:
    # Fallback if uvicorn adapter not available
    application = wsgi_application

# Vercel will look for 'app' variable or handler function
app = application



