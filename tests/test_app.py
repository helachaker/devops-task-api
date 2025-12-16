"""
Unit tests for Task Manager API
"""
import pytest
import json
import os
import sys
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from app import app, init_db

@pytest.fixture
def client():
    """Create test client"""
    app.config['TESTING'] = True
    os.environ['DB_PATH'] = ':memory:'
    with app.test_client() as client:
        with app.app_context():
            init_db()
        yield client

def test_health_check(client):
    """Test health endpoint"""
    response = client.get('/health')
    assert response.status_code == 200
    data = json.loads(response.data)
    assert data['status'] == 'healthy'

def test_metrics_endpoint(client):
    """Test metrics endpoint"""
    response = client.get('/metrics')
    assert response.status_code == 200

def test_create_task(client):
    """Test task creation"""
    response = client.post('/tasks', 
                          data=json.dumps({'title': 'Test Task', 'description': 'Test'}),
                          content_type='application/json')
    assert response.status_code == 201
    data = json.loads(response.data)
    assert 'id' in data

def test_get_tasks(client):
    """Test getting all tasks"""
    client.post('/tasks', 
                data=json.dumps({'title': 'Task 1'}),
                content_type='application/json')
    response = client.get('/tasks')
    assert response.status_code == 200
    data = json.loads(response.data)
    assert isinstance(data, list)
    assert len(data) > 0

def test_get_task_by_id(client):
    """Test getting specific task"""
    create_response = client.post('/tasks',
                                   data=json.dumps({'title': 'Specific Task'}),
                                   content_type='application/json')
    task_id = json.loads(create_response.data)['id']
    
    response = client.get(f'/tasks/{task_id}')
    assert response.status_code == 200
    data = json.loads(response.data)
    assert data['title'] == 'Specific Task'

def test_update_task(client):
    """Test task update"""
    create_response = client.post('/tasks',
                                   data=json.dumps({'title': 'Old Title'}),
                                   content_type='application/json')
    task_id = json.loads(create_response.data)['id']
    
    response = client.put(f'/tasks/{task_id}',
                         data=json.dumps({'title': 'New Title', 'status': 'completed'}),
                         content_type='application/json')
    assert response.status_code == 200
    
    get_response = client.get(f'/tasks/{task_id}')
    data = json.loads(get_response.data)
    assert data['title'] == 'New Title'
    assert data['status'] == 'completed'

def test_delete_task(client):
    """Test task deletion"""
    create_response = client.post('/tasks',
                                   data=json.dumps({'title': 'To Delete'}),
                                   content_type='application/json')
    task_id = json.loads(create_response.data)['id']
    
    response = client.delete(f'/tasks/{task_id}')
    assert response.status_code == 200
    
    get_response = client.get(f'/tasks/{task_id}')
    assert get_response.status_code == 404

def test_create_task_missing_title(client):
    """Test task creation without title"""
    response = client.post('/tasks',
                          data=json.dumps({'description': 'No title'}),
                          content_type='application/json')
    assert response.status_code == 400

def test_get_nonexistent_task(client):
    """Test getting non-existent task"""
    response = client.get('/tasks/99999')
    assert response.status_code == 404

def test_update_nonexistent_task(client):
    """Test updating non-existent task"""
    response = client.put('/tasks/99999',
                         data=json.dumps({'title': 'New Title'}),
                         content_type='application/json')
    assert response.status_code == 404

def test_delete_nonexistent_task(client):
    """Test deleting non-existent task"""
    response = client.delete('/tasks/99999')
    assert response.status_code == 404
