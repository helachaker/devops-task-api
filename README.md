#  Task Manager API - DevOps Project

[![CI/CD Pipeline](https://github.com/helachaker/devops-task-api/actions/workflows/ci-cd.yml/badge.svg)](https://github.com/helachaker/devops-task-api/actions)
[![Docker Image](https://img.shields.io/docker/v/YOUR_USERNAME/task-api?label=Docker&logo=docker)](https://hub.docker.com/r/YOUR_USERNAME/task-api)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A simple yet comprehensive REST API demonstrating DevOps best practices including CI/CD, containerization, orchestration, observability, and security scanning.

## 📋 Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [API Documentation](#api-documentation)
- [Docker Usage](#docker-usage)
- [Kubernetes Deployment](#kubernetes-deployment)
- [Observability](#observability)
- [Security](#security)
- [Development](#development)
- [CI/CD Pipeline](#cicd-pipeline)

## ✨ Features

- ✅ RESTful API for task management (CRUD operations)
- ✅ Prometheus metrics for monitoring
- ✅ Structured JSON logging
- ✅ Health check endpoint
- ✅ Docker containerization with multi-stage builds
- ✅ Kubernetes deployment manifests
- ✅ Automated CI/CD with GitHub Actions
- ✅ Security scanning (SAST & DAST)
- ✅ Comprehensive unit tests
- ✅ Production-ready with Gunicorn

## 🛠️ Tech Stack

| Category | Technology |
|----------|-----------|
| **Backend** | Python 3.11, Flask |
| **Database** | SQLite |
| **Containerization** | Docker, Docker Compose |
| **Orchestration** | Kubernetes (minikube/kind) |
| **CI/CD** | GitHub Actions |
| **Monitoring** | Prometheus, Grafana |
| **Security** | Bandit (SAST), Safety, OWASP ZAP (DAST), Trivy |
| **Testing** | Pytest |

## 📦 Prerequisites

- Python 3.11+
- Docker & Docker Compose
- Kubernetes (minikube or kind)
- kubectl
- Git

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/devops-task-api.git
cd devops-task-api
```

### 2. Run Locally (without Docker)

```bash
# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Run the application
python app.py
```

The API will be available at `http://localhost:5000`

### 3. Run with Docker Compose (Recommended)

```bash
# Start all services (API + Prometheus + Grafana)
docker-compose up -d

# View logs
docker-compose logs -f app

# Stop services
docker-compose down
```

**Access Points:**
- API: http://localhost:5000
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000 (admin/admin)

## 📚 API Documentation

### Base URL
```
http://localhost:5000
```

### Endpoints

#### Health Check
```bash
GET /health
```
**Response:**
```json
{
  "status": "healthy",
  "timestamp": "2024-12-16T10:30:00"
}
```

#### Metrics
```bash
GET /metrics
```
Returns Prometheus-formatted metrics.

#### Create Task
```bash
POST /tasks
Content-Type: application/json

{
  "title": "Complete DevOps project",
  "description": "Implement full CI/CD pipeline",
  "status": "pending"
}
```
**Response (201):**
```json
{
  "id": 1,
  "message": "Task created successfully"
}
```

#### Get All Tasks
```bash
GET /tasks
```
**Response (200):**
```json
[
  {
    "id": 1,
    "title": "Complete DevOps project",
    "description": "Implement full CI/CD pipeline",
    "status": "pending",
    "created_at": "2024-12-16 10:30:00"
  }
]
```

#### Get Task by ID
```bash
GET /tasks/{id}
```
**Response (200):**
```json
{
  "id": 1,
  "title": "Complete DevOps project",
  "description": "Implement full CI/CD pipeline",
  "status": "pending",
  "created_at": "2024-12-16 10:30:00"
}
```

#### Update Task
```bash
PUT /tasks/{id}
Content-Type: application/json

{
  "title": "Updated title",
  "status": "completed"
}
```
**Response (200):**
```json
{
  "message": "Task updated successfully"
}
```

#### Delete Task
```bash
DELETE /tasks/{id}
```
**Response (200):**
```json
{
  "message": "Task deleted successfully"
}
```

### Example Usage

```bash
# Create a task
curl -X POST http://localhost:5000/tasks \
  -H "Content-Type: application/json" \
  -d '{"title":"Learn Kubernetes","status":"pending"}'

# Get all tasks
curl http://localhost:5000/tasks

# Update a task
curl -X PUT http://localhost:5000/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{"status":"completed"}'

# Delete a task
curl -X DELETE http://localhost:5000/tasks/1
```

## 🐳 Docker Usage

### Build Image Locally

```bash
docker build -t task-api:local .
```

### Run Container

```bash
docker run -d -p 5000:5000 --name task-api task-api:local
```

### Push to Docker Hub

```bash
# Login
docker login

# Tag image
docker tag task-api:local YOUR_USERNAME/task-api:latest

# Push
docker push YOUR_USERNAME/task-api:latest
```

## ☸️ Kubernetes Deployment

### Using minikube

```bash
# Start minikube
minikube start

# Update image in k8s/deployment.yaml with your Docker Hub username
sed -i 's/YOUR_DOCKERHUB_USERNAME/your-username/g' k8s/deployment.yaml

# Apply manifests
kubectl apply -f k8s/

# Check deployment
kubectl get deployments
kubectl get pods
kubectl get services

# Access the application
minikube service task-api-service --url

# Or use port forwarding
kubectl port-forward service/task-api-service 8080:80
```

### Scale the Application

```bash
# Manual scaling
kubectl scale deployment task-api --replicas=5

# Autoscaling (HPA already configured)
kubectl get hpa
```

### View Logs

```bash
# All pods
kubectl logs -l app=task-api --tail=100 -f

# Specific pod
kubectl logs <pod-name> -f
```

### Cleanup

```bash
kubectl delete -f k8s/
minikube stop
```

## 📊 Observability

### Metrics

The application exposes Prometheus metrics at `/metrics`:

- `api_requests_total`: Total number of API requests (labeled by method, endpoint, status)
- `api_request_duration_seconds`: Request latency histogram

**View Metrics:**
```bash
curl http://localhost:5000/metrics
```

### Logs

Structured JSON logs for all requests and errors:

```bash
# Docker Compose
docker-compose logs -f app

# Kubernetes
kubectl logs -l app=task-api -f
```

### Grafana Dashboard

1. Access Grafana: http://localhost:3000
2. Login: admin/admin
3. Add Prometheus data source: http://prometheus:9090
4. Import dashboard or create custom queries

**Example PromQL Queries:**
```promql
# Request rate
rate(api_requests_total[5m])

# Error rate
rate(api_requests_total{status=~"5.."}[5m])

# P95 latency
histogram_quantile(0.95, rate(api_request_duration_seconds_bucket[5m]))
```

## 🔒 Security

### SAST (Static Analysis)

The project uses **Bandit** for static security analysis:

```bash
# Run locally
pip install bandit
bandit -r . -f json -o bandit-report.json
```

### Dependency Scanning

Using **Safety** to check for vulnerable dependencies:

```bash
pip install safety
safety check
```

### Container Scanning

**Trivy** scans Docker images for vulnerabilities:

```bash
# Install Trivy
# See: https://aquasecurity.github.io/trivy/

# Scan image
trivy image YOUR_USERNAME/task-api:latest
```

### DAST (Dynamic Analysis)

**OWASP ZAP** performs runtime security testing:

```bash
# Using Docker
docker run -t owasp/zap2docker-stable zap-baseline.py \
  -t http://localhost:5000
```

All security scans are automated in the CI/CD pipeline.

## 💻 Development

### Running Tests

```bash
# Run all tests
pytest tests/ -v

# With coverage
pytest tests/ --cov=app --cov-report=html

# Open coverage report
open htmlcov/index.html
```

### Project Structure

```
devops-task-api/
├── .github/
│   └── workflows/
│       └── ci-cd.yml          # GitHub Actions workflow
├── k8s/
│   ├── deployment.yaml        # K8s deployment & service
│   ├── configmap.yaml         # Configuration
│   └── hpa.yaml               # Horizontal Pod Autoscaler
├── tests/
│   ├── __init__.py
│   └── test_app.py            # Unit tests
├── .zap/
│   └── rules.tsv              # OWASP ZAP rules
├── app.py                     # Main application
├── requirements.txt           # Python dependencies
├── Dockerfile                 # Multi-stage Docker build
├── docker-compose.yml         # Local dev environment
├── prometheus.yml             # Prometheus config
├── .dockerignore
├── .gitignore
├── .bandit                    # Bandit config
└── README.md
```

## 🔄 CI/CD Pipeline

The GitHub Actions workflow automatically:

1. **Test**: Runs unit tests with coverage
2. **SAST**: Performs static security analysis (Bandit, Safety)
3. **Build**: Creates Docker image and pushes to Docker Hub
4. **Scan**: Scans container with Trivy
5. **DAST**: Runs OWASP ZAP security tests
6. **Notify**: Reports deployment status

### Setting Up CI/CD

1. Fork this repository
2. Add GitHub Secrets:
   - `DOCKER_USERNAME`: Your Docker Hub username
   - `DOCKER_PASSWORD`: Your Docker Hub password/token
3. Push to main branch to trigger the pipeline

### Pipeline Status

View the pipeline status in the Actions tab of your repository.

## 🤝 Contributing

### Making Changes

1. Create a GitHub Issue for your task
2. Create a feature branch: `git checkout -b feature/issue-XX`
3. Make your changes
4. Run tests: `pytest tests/`
5. Commit: `git commit -m "feat: description (closes #XX)"`
6. Push: `git push origin feature/issue-XX`
7. Create a Pull Request

### Peer Review Guidelines

When reviewing PRs:
- ✅ Check code quality and style
- ✅ Verify tests pass
- ✅ Review security implications
- ✅ Test locally if possible
- ✅ Provide constructive feedback

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flask Documentation
- Kubernetes Documentation
- Prometheus Best Practices
- OWASP Security Guidelines

## 📧 Contact

Hela Chaker - helachaker01@gmail.com

Project Link: [https://github.com/helachaker/devops-task-api](https://github.com/helachaker/devops-task-api)

---

**Made with ❤️ for DevOps Learning**
