# DQA REST API

## EXECUTE DEDUPLICATION
```sh
curl -X POST http://127.0.0.1:5000/start-deduplication -H "Content-Type: application/json" -d "{\"threshold\":95, \"subset\":10000}"
```

## CHECK TASK STATUS
```sh
curl http://localhost:5000/task-status/%1
```

## FOR TESTING

### Fetch Single Record
```sh
curl -X GET http://127.0.0.1:5000/test_single/1
```

### Insert
```sh
curl -X POST http://127.0.0.1:5000/test_create \
     -H "Content-Type: application/json" \
     -d '{"name": "John Doe", "score": 85, "description": "Test description", "dt": "2025-03-01"}'
```

### Update
```sh
curl -X PUT http://127.0.0.1:5000/test_update/1 \
     -H "Content-Type: application/json" \
     -d '{"name": "Updated Name", "score": 95, "description": "Updated description", "dt": "2025-03-02"}'
```

### Upsert
```sh
curl -X PUT http://127.0.0.1:5000/test_upsert/1 \
     -H "Content-Type: application/json" \
     -d '{"name": "Upserted Name", "score": 90, "description": "Upserted description", "dt": "2025-03-02"}'
```

### Delete
```sh
curl -X DELETE http://127.0.0.1:5000/test_delete/1
```

## HOW TO RUN
```sh
celery -A app.celery worker --loglevel=INFO --pool=solo
".\redis\redis-server.exe" ".\redis\redis.windows.conf"
python app.py
```

## HOW TO CONFIGURE DATABASE
1. Open the `.env` file and configure your database settings:
   ```env
   DATABASE_URI=mysql://user:password@localhost:3306/db_name
   ```
2. Ensure MySQL/PostgreSQL is running.
3. Apply migrations:
   ```sh
   flask db upgrade
   ```

## HOW TO ADD SSL FOR HTTPS
1. Obtain an SSL certificate (e.g., Let's Encrypt or self-signed certificate).
2. Configure Flask to use HTTPS:
   ```python
   from flask import Flask
   from flask_sslify import SSLify

   app = Flask(__name__)
   sslify = SSLify(app)
   ```
3. If using Nginx, update the configuration:
   ```nginx
   server {
       listen 443 ssl;
       ssl_certificate /path/to/cert.pem;
       ssl_certificate_key /path/to/key.pem;
       location / {
           proxy_pass http://127.0.0.1:5000;
       }
   }
   ```

## HOW TO ALLOW ONLY CERTAIN IPs TO ACCESS THE API (LIKE WEB SERVERS)
1. Modify `app.py` to restrict access:
   ```python
   from flask import request, abort

   ALLOWED_IPS = ["192.168.1.100", "203.0.113.0"]

   @app.before_request
   def limit_remote_addr():
       if request.remote_addr not in ALLOWED_IPS:
           abort(403)
   ```
2. If using Nginx, update the configuration:
   ```nginx
   server {
       allow 192.168.1.100;
       allow 203.0.113.0;
       deny all;
   }
   ```

## HOW TO MIGRATE DATABASE MODELS
1. Initialize migrations (first time only):
   ```sh
   flask db init
   ```
2. Generate migration scripts after model changes:
   ```sh
   flask db migrate -m "Updated models"
   ```
3. Apply migrations:
   ```sh
   flask db upgrade
   
