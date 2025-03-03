# pip install Flask flask-cors pandas sqlalchemy pymysql rapidfuzz fuzzy xlsxwriter Flask-Migrate sqlacodegen flask-cors
# pip install mysql-connector-python

from flask import Flask, request, jsonify
from celery import Celery
from flask_sqlalchemy import SQLAlchemy
from models import TblRoster, TblTestReadWrite, db
from flask_cors import CORS
from flask_migrate import Migrate
from data_services import get_data




app = Flask(__name__)

# CORS Configuration  
# Only include the addresses of web servers that use this REST API.  
# This prevents unauthorized access from unknown locations via JavaScript  
# This will also blocks direct browser access  
# Allowed origins for JavaScript requests
ALLOWED_ORIGINS = {
    "https://172.31.196.14:8081",
    "https://192.168.1.11:8081",
    "*" # allow temporarily  
}

# CORS(app, resources={r"/*": {"origins": list(ALLOWED_ORIGINS)}})
# @app.before_request
# def block_direct_browser_access():
#     origin = request.headers.get("Origin")
#     referer = request.headers.get("Referer")

#     # Block requests with no Origin/Referer (direct browser access)
#     if not origin and not referer:
#         return jsonify({
#             "error": "Direct access is not allowed",
#             "ip": request.remote_addr,
#             'origin': origin
#             }), 403

#     # Block requests from unauthorized origins
#     if origin and origin not in ALLOWED_ORIGINS:
#         return jsonify({"error": "Unauthorized access"}), 403


# MySQL Database Configuration
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:@localhost:3307/db_pantawid'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
# app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///db_pantawid.sqlite3' #sqlite

# Celery Configuration
app.config['CELERY_BROKER_URL'] = 'redis://localhost:8095/0'
app.config['CELERY_RESULT_BACKEND'] = 'redis://localhost:8095/0'

# db = SQLAlchemy(app)

# Initialize db with app
# db.init_app(app)


# Initialize Flask-Migrate
# Ensure proper table creation
# migrate = Migrate(app, db)  
# with app.app_context():
#     db.create_all()


# Initialize Database
db.init_app(app)

# Initialize Flask-Migrate
migrate = Migrate(app, db)  


# Ensure proper table creation
with app.app_context():
    db.create_all()





celery = Celery(app.name, broker=app.config['CELERY_BROKER_URL'])
celery.conf.update(app.config)

# Import tasks to register them
import tasks  # Ensure this is imported so Celery recognizes tasks
## -----------------------------------------------------------------


@app.route('/sample/<param1>/<param2>')
def sample(param1, param2):
    return [{
        'data':get_data(1),
        'param1': param1,
        'param2': param2,

    }]

@app.route('/sample_post', methods=['POST'])
def sample_post():
    data = request.json  # Expecting JSON data in request body
    param1 = data.get('param1')
    param2 = data.get('param2')

    return jsonify([{
        'data': get_data(1),
        'param1': param1,
        'param2': param2,
        'ip' : request.remote_addr
    }])


# CRUD TESTS --------------------------------------------------------------------------------
@app.route('/test_create', methods=['POST'])
def test_create():
    """Create a new entry in tbl_test"""
    data = request.json
    print("Received Data:", data)  # Debugging

    if not data.get('name') or data.get('score') is None:
        return jsonify({'success': False, 'message': 'Name and score are required'}), 400

    new_entry = TblTestReadWrite(
        name=data['name'],
        score=int(data['score']),  # Convert to integer if needed
        description=data.get('description', ''),
        dt=data.get('dt')
    )
    db.session.add(new_entry)
    db.session.commit()

    return jsonify({'success': True, 'message': 'Record added', 'id': new_entry.id}), 201

# working
@app.route('/test_all', methods=['GET'])
def get_all_tests():
    """Retrieve all records from tbl_test"""
    records = TblTestReadWrite.query.all()
    return jsonify([
        {'id': r.id, 'name': r.name, 'description': r.description} for r in records
    ]), 200

# working
@app.route('/test_single/<int:id>', methods=['GET'])
def get_test(id):
    print('asdasdasd');
    """Retrieve a single record by ID"""
    record = TblTestReadWrite.query.get(id)
    if not record:
        return jsonify({'success': False, 'message': 'Record not found'}), 404

    return jsonify({'id': record.id, 'name': record.name, 'description': record.description}), 200


@app.route('/test_delete/<int:id>', methods=['DELETE'])
def delete_test(id):
    """Delete a record from tbl_test"""
    record = TblTestReadWrite.query.get(id)
    if not record:
        return jsonify({'success': False, 'message': 'Record not found'}), 404

    db.session.delete(record)
    db.session.commit()
    
    return jsonify({'success': True, 'message': 'Record deleted'}), 200

@app.route('/test_update/<int:id>', methods=['PUT'])
def update_test(id):
    """Update an existing record in tbl_test"""
    record = TblTestReadWrite.query.get(id)
    if not record:
        return jsonify({'success': False, 'message': 'Record not found'}), 404

    data = request.json
    if not data:
        return jsonify({'success': False, 'message': 'No data provided'}), 400

    try:
        record.name = data.get('name', record.name)
        record.score = int(data.get('score', record.score))  # Ensure conversion to integer
        record.description = data.get('description', record.description)
        record.dt = data.get('dt', record.dt)

        db.session.commit()
        return jsonify({'success': True, 'message': 'Record updated'}), 200
    except ValueError:
        return jsonify({'success': False, 'message': 'Invalid score format'}), 400
    except Exception as e:
        db.session.rollback()
        return jsonify({'success': False, 'message': str(e)}), 500


@app.route('/test_upsert/<int:id>', methods=['PUT'])
def test_upsert(id):
    """Update the record if it exists; otherwise, create a new one"""
    data = request.json

    if not data.get('name') or data.get('score') is None:
        return jsonify({'success': False, 'message': 'Name and score are required'}), 400

    record = TblTestReadWrite.query.get(id)

    if record:
        # Update existing record
        record.name = data['name']
        record.score = int(data['score'])
        record.description = data.get('description', '')
        record.dt = data.get('dt')
        message = 'Record updated'
    else:
        # Insert new record
        record = TblTestReadWrite(
            id=id,  # Set ID manually
            name=data['name'],
            score=int(data['score']),
            description=data.get('description', ''),
            dt=data.get('dt')
        )
        db.session.add(record)
        message = 'New record created'

    db.session.commit()
    return jsonify({'success': True, 'message': message, 'id': record.id}), 200

## -----------------------------------------------------------------

@app.route('/get_roster/<hh_id>', methods=['GET'])
def get_roster(hh_id):
    roster = TblRoster.query.filter_by(hh_id=hh_id).first()
    if roster:
        return jsonify(roster.to_dict())
    return jsonify({"error": "Record not found"}), 404

## -----------------------------------------------------------------
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

    # app.run(
    #     host='127.0.0.1',
    #     port=5000,
    #     debug=True,
    #     ssl_context=('./certs/server.crt', './certs/server.key')
    # )

    # running api with certificate from the main app (xampp)
    # cert_key = 'C:/xampp/apache/conf/ssl.key/server.key'
    # cert_pem = 'C:/xampp/apache/conf/ssl.crt/server.crt'
    # app.run(
    #     host='172.31.196.14',
    #     port=5000,
    #     debug=True,
    #     ssl_context=(cert_pem, cert_key)
    # )


