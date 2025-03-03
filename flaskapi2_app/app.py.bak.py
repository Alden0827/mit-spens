from flask import Flask, request, jsonify
from celery import Celery
from flask_sqlalchemy import SQLAlchemy
from models import TblRoster

app = Flask(__name__)

# MySQL Database Configuration
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:@localhost:3307/db_pantawid'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Celery Configuration
app.config['CELERY_BROKER_URL'] = 'redis://localhost:8095/0'
app.config['CELERY_RESULT_BACKEND'] = 'redis://localhost:8095/0'

db = SQLAlchemy(app)

celery = Celery(app.name, broker=app.config['CELERY_BROKER_URL'])
celery.conf.update(app.config)

# Import tasks to register them
import tasks  # Ensure this is imported so Celery recognizes tasks

@app.route('/start-deduplication', methods=['POST'])
def start_deduplication():
    from tasks import deduplicate  # Lazy import to prevent circular dependency
    data = request.get_json()
    threshold = data.get('threshold', 50)
    subset = data.get('subset', 1000)
    task = deduplicate.apply_async(args=[threshold, subset])
    return jsonify({"task_id": task.id, "status": "started"}), 202

@app.route('/task-status/<task_id>', methods=['GET'])
def task_status(task_id):
    task = celery.AsyncResult(task_id)
    response = {
        "state": task.state,
        "status": str(task.info) if task.info else "No status available"
    }
    return jsonify(response)

if __name__ == '__main__':
    app.run(port=5000, debug=True)
