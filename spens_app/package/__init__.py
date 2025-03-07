from __future__ import absolute_import, unicode_literals

# Import the celery app so it's available throughout the project
from .celery import app as celery_app

__all__ = ('celery_app',)