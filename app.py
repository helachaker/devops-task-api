"""Task Manager API - DevOps Project"""
import logging
import time
from datetime import datetime
from flask import Flask, request, jsonify, Response

from prometheus_client import Counter, Histogram, generate_latest
import sqlite3
import os

# Initialize Flask app
app = Flask(__name__)

# Configure structured logging
logging.basicConfig(
    level=logging.INFO,
    format='{"time":"%(asctime)s", "level":"%(levelname)s", "message":"%(message)s"}'
)
logger = logging.getLogger(__name__)

# Prometheus metrics
REQUEST_COUNT = Counter('api_requests_total', 'Total API requests', ['method', 'endpoint', 'status'])
REQUEST_LATENCY = Histogram('api_request_duration_seconds', 'Request latency', ['endpoint'])

# Database setup
DB_PATH = os.getenv('DB_PATH', 'tasks.db')

def init_db():
    """Initialize SQLite database"""
    conn = sqlite3.connect(DB_PATH)
    conn.execute('''CREATE TABLE IF NOT EXISTS tasks
                    (id INTEGER PRIMARY KEY AUTOINCREMENT,
                     title TEXT NOT NULL,
                     description TEXT,
                     status TEXT DEFAULT 'pending',
                     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)''')
    conn.commit()
    conn.close()
    logger.info("Database initialized")

def get_db():
    """Get database connection"""
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn

@app.before_request
def before_request():
    """Log and track request start time"""
    request.start_time = time.time()
    logger.info(f"Incoming request: {request.method} {request.path}")

@app.after_request
def after_request(response):
    """Log response and update metrics"""
    latency = time.time() - request.start_time
    REQUEST_COUNT.labels(request.method, request.path, response.status_code).inc()
    REQUEST_LATENCY.labels(request.path).observe(latency)
    logger.info(f"Response: {response.status_code} - Latency: {latency:.3f}s")
    return response

@app.route('/health', methods=['GET'])
def health():
    """Health check endpoint"""
    return jsonify({"status": "healthy", "timestamp": datetime.now().isoformat()}), 200

@app.route('/metrics', methods=['GET'])
def metrics():
    """Prometheus metrics endpoint"""
    return Response(generate_latest(), mimetype='text/plain; version=0.0.4; charset=utf-8')

@app.route('/tasks', methods=['GET'])
def get_tasks():
    """Get all tasks"""
    conn = get_db()
    tasks = conn.execute('SELECT * FROM tasks ORDER BY created_at DESC').fetchall()
    conn.close()
    return jsonify([dict(task) for task in tasks]), 200

@app.route('/tasks/<int:task_id>', methods=['GET'])
def get_task(task_id):
    """Get a specific task"""
    conn = get_db()
    task = conn.execute('SELECT * FROM tasks WHERE id = ?', (task_id,)).fetchone()
    conn.close()
    if task:
        return jsonify(dict(task)), 200
    logger.warning(f"Task not found: {task_id}")
    return jsonify({"error": "Task not found"}), 404

@app.route('/tasks', methods=['POST'])
def create_task():
    """Create a new task"""
    data = request.get_json()
    if not data or 'title' not in data:
        return jsonify({"error": "Title is required"}), 400
    
    conn = get_db()
    cursor = conn.execute(
        'INSERT INTO tasks (title, description, status) VALUES (?, ?, ?)',
        (data['title'], data.get('description', ''), data.get('status', 'pending'))
    )
    conn.commit()
    task_id = cursor.lastrowid
    conn.close()
    logger.info(f"Task created: {task_id}")
    return jsonify({"id": task_id, "message": "Task created successfully"}), 201

@app.route('/tasks/<int:task_id>', methods=['PUT'])
def update_task(task_id):
    """Update a task"""
    data = request.get_json()
    conn = get_db()
    task = conn.execute('SELECT * FROM tasks WHERE id = ?', (task_id,)).fetchone()
    if not task:
        conn.close()
        return jsonify({"error": "Task not found"}), 404
    
    conn.execute(
        'UPDATE tasks SET title = ?, description = ?, status = ? WHERE id = ?',
        (data.get('title', task['title']), 
         data.get('description', task['description']),
         data.get('status', task['status']), 
         task_id)
    )
    conn.commit()
    conn.close()
    logger.info(f"Task updated: {task_id}")
    return jsonify({"message": "Task updated successfully"}), 200

@app.route('/tasks/<int:task_id>', methods=['DELETE'])
def delete_task(task_id):
    """Delete a task"""
    conn = get_db()
    result = conn.execute('DELETE FROM tasks WHERE id = ?', (task_id,))
    conn.commit()
    conn.close()
    if result.rowcount > 0:
        logger.info(f"Task deleted: {task_id}")
        return jsonify({"message": "Task deleted successfully"}), 200
    return jsonify({"error": "Task not found"}), 404

@app.errorhandler(Exception)
def handle_error(error):
    """Global error handler"""
    logger.error(f"Unhandled error: {str(error)}")
    return jsonify({"error": "Internal server error"}), 500

init_db()

if __name__ == '__main__':

    app.run(host='0.0.0.0', port=5000, debug=False)
