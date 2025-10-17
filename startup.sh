#!/bin/bash

if [ "$DJANGO_ENVIRONMENT" = "development" ]; then
    echo "Development environment detected, installing dev dependencies..."
    uv sync --extra dev
else
    echo "Production environment, using base dependencies only"
    uv sync
fi

uv run manage.py collectstatic --noinput

if [ "$DJANGO_ENVIRONMENT" = "development" ]; then
    uv run python manage.py makemigrations users authentication posts notifications chat || true
else
    echo "Skipping makemigrations in production"
fi

uv run python manage.py migrate --noinput

uv run daphne config.asgi:application -b 0.0.0.0 -p 8000