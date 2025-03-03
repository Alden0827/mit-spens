# context_processors.py
from django.conf import settings

def my_settings(request):
    return {
        'app_program': settings.APP_PROGRAM, 
        'app_name': settings.APP_NAME, 
        'app_version': settings.APP_VERSION, 

    }
