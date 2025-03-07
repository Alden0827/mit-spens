from django.apps import AppConfig


class DedupeAppConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'dedupe_app'
