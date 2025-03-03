rem celery -A app.celery worker --loglevel=INFO
celery -A app.celery worker --loglevel=INFO --pool=solo

pause