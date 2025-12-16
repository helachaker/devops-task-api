#!/bin/bash

# Task Manager API - Deployment Commands
# Collection of useful commands for project setup and deployment

echo "======================================"
echo "Task Manager API - Deployment Guide"
echo "======================================"
echo ""

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_section() {
    echo ""
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
}

print_command() {
    echo -e "${GREEN}➜${NC} $1"
    echo -e "${YELLOW}  $2${NC}"
    echo ""
}

# ============================================
# SECTION 1: Initial Setup
# ============================================
print_section "1. INITIAL SETUP"

print_command "Clone repository" \
"git clone https://github.com/YOUR_USERNAME/devops-task-api.git && cd devops-task-api"

print_command "Create Python virtual environment" \
"python -m venv venv && source venv/bin/activate"

print_command "Install dependencies" \
"pip install -r requirements.txt"

# ============================================
# SECTION 2: Local Testing
# ============================================
print_section "2. LOCAL TESTING"

print_command "Run application locally" \
"python app.py"

print_command "Test health endpoint" \
"curl http://localhost:5000/health"

print_command "Create a test task" \
"curl -X POST http://localhost:5000/tasks -H 'Content-Type: application/json' -d '{\"title\":\"Test Task\",\"description\":\"Testing API\"}'"

print_command "Get all tasks" \
"curl http://localhost:5000/tasks"

print_command "View metrics" \
"curl http://localhost:5000/metrics"

print_command "Run unit tests" \
"pytest tests/ -v"

print_command "Run tests with coverage" \
"pytest tests/ --cov=app --cov-report=html"

# ============================================
# SECTION 3: Docker Commands
# ============================================
print_section "3. DOCKER OPERATIONS"

print_command "Build Docker image" \
"docker build -t task-api:local ."

print_command "Run Docker container" \
"docker run -d -p 5000:5000 --name task-api task-api:local"

print_command "View container logs" \
"docker logs -f task-api"

print_command "Stop and remove container" \
"docker stop task-api && docker rm task-api"

print_command "Tag image for Docker Hub" \
"docker tag task-api:local YOUR_USERNAME/task-api:latest"

print_command "Login to Docker Hub" \
"docker login"

print_command "Push image to Docker Hub" \
"docker push YOUR_USERNAME/task-api:latest"

# ============================================
# SECTION 4: Docker Compose
# ============================================
print_section "4. DOCKER COMPOSE (Recommended)"

print_command "Start all services (API + Prometheus + Grafana)" \
"docker-compose up -d"

print_command "View logs" \
"docker-compose logs -f app"

print_command "Check services status" \
"docker-compose ps"

print_command "Stop all services" \
"docker-compose down"

print_command "Rebuild and restart" \
"docker-compose up -d --build"

echo "  📊 Access Points:"
echo "  - API: http://localhost:5000"
echo "  - Prometheus: http://localhost:9090"
echo "  - Grafana: http://localhost:3000 (admin/admin)"
echo ""

# ============================================
# SECTION 5: Security Scans
# ============================================
print_section "5. SECURITY SCANNING"

print_command "Install security tools" \
"pip install bandit safety"

print_command "Run Bandit (SAST)" \
"bandit -r . -f json -o bandit-report.json"

print_command "Run Safety (Dependency scan)" \
"safety check"

print_command "Scan Docker image with Trivy" \
"trivy image YOUR_USERNAME/task-api:latest"

print_command "Run OWASP ZAP scan (Docker)" \
"docker run -t owasp/zap2docker-stable zap-baseline.py -t http://host.docker.internal:5000"

# ============================================
# SECTION 6: Kubernetes Deployment
# ============================================
print_section "6. KUBERNETES DEPLOYMENT"

print_command "Start minikube" \
"minikube start --cpus=2 --memory=4096"

print_command "Update deployment image" \
"sed -i 's/YOUR_DOCKERHUB_USERNAME/your-actual-username/g' k8s/deployment.yaml"

print_command "Apply all Kubernetes manifests" \
"kubectl apply -f k8s/"

print_command "Check deployment status" \
"kubectl get deployments"

print_command "Check pods" \
"kubectl get pods"

print_command "Check services" \
"kubectl get services"

print_command "Get service URL (minikube)" \
"minikube service task-api-service --url"

print_command "Port forward to access locally" \
"kubectl port-forward service/task-api-service 8080:80"

print_command "View pod logs" \
"kubectl logs -l app=task-api --tail=100 -f"

print_command "Scale deployment manually" \
"kubectl scale deployment task-api --replicas=5"

print_command "Check HPA (Horizontal Pod Autoscaler)" \
"kubectl get hpa"

print_command "Describe deployment" \
"kubectl describe deployment task-api"

print_command "Delete all resources" \
"kubectl delete -f k8s/"

print_command "Stop minikube" \
"minikube stop"

# ============================================
# SECTION 7: GitHub Actions Setup
# ============================================
print_section "7. GITHUB ACTIONS SETUP"

echo "1. Go to your GitHub repository Settings > Secrets and variables > Actions"
echo "2. Add the following secrets:"
echo "   - DOCKER_USERNAME: Your Docker Hub username"
echo "   - DOCKER_PASSWORD: Your Docker Hub password or access token"
echo ""
echo "3. Push to main branch to trigger the pipeline:"
print_command "Push to GitHub" \
"git add . && git commit -m 'feat: initial commit' && git push origin main"

echo "4. View pipeline status:"
echo "   https://github.com/YOUR_USERNAME/devops-task-api/actions"
echo ""

# ============================================
# SECTION 8: Monitoring & Observability
# ============================================
print_section "8. MONITORING & OBSERVABILITY"

print_command "View Prometheus targets" \
"open http://localhost:9090/targets"

print_command "Query request rate (PromQL)" \
"rate(api_requests_total[5m])"

print_command "Query error rate (PromQL)" \
"rate(api_requests_total{status=~\"5..\"}[5m])"

print_command "Query P95 latency (PromQL)" \
"histogram_quantile(0.95, rate(api_request_duration_seconds_bucket[5m]))"

echo "  Access Grafana at http://localhost:3000"
echo "  1. Login with admin/admin"
echo "  2. Add data source: http://prometheus:9090"
echo "  3. Create dashboard with above queries"
echo ""

# ============================================
# SECTION 9: Testing the API
# ============================================
print_section "9. API TESTING EXAMPLES"

print_command "Health check" \
"curl http://localhost:5000/health"

print_command "Create task" \
"curl -X POST http://localhost:5000/tasks -H 'Content-Type: application/json' -d '{\"title\":\"Deploy to K8s\",\"description\":\"Complete Kubernetes deployment\",\"status\":\"in_progress\"}'"

print_command "Get all tasks" \
"curl http://localhost:5000/tasks | jq"

print_command "Get specific task" \
"curl http://localhost:5000/tasks/1 | jq"

print_command "Update task" \
"curl -X PUT http://localhost:5000/tasks/1 -H 'Content-Type: application/json' -d '{\"status\":\"completed\"}'"

print_command "Delete task" \
"curl -X DELETE http://localhost:5000/tasks/1"

# ============================================
# SECTION 10: Cleanup
# ============================================
print_section "10. CLEANUP COMMANDS"

print_command "Stop Docker Compose services" \
"docker-compose down -v"

print_command "Remove Docker images" \
"docker rmi task-api:local YOUR_USERNAME/task-api:latest"

print_command "Delete Kubernetes resources" \
"kubectl delete -f k8s/"

print_command "Stop minikube" \
"minikube delete"

print_command "Deactivate Python venv" \
"deactivate"

# ============================================
# SECTION 11: Troubleshooting
# ============================================
print_section "11. TROUBLESHOOTING"

echo "Issue: Container fails to start"
print_command "Check logs" \
"docker logs task-api"

echo "Issue: Kubernetes pods not ready"
print_command "Describe pod" \
"kubectl describe pod <pod-name>"

echo "Issue: Service not accessible"
print_command "Check service endpoints" \
"kubectl get endpoints"

echo "Issue: Metrics not showing in Prometheus"
print_command "Check if target is up" \
"curl http://localhost:9090/api/v1/targets"

echo "Issue: Tests failing"
print_command "Run tests in verbose mode" \
"pytest tests/ -vv -s"

# ============================================
# END
# ============================================
echo ""
echo -e "${GREEN}======================================"
echo "Setup complete! Choose a section above"
echo "and run the commands step by step."
echo -e "======================================${NC}"
echo ""
echo "Quick Start: docker-compose up -d"
echo ""
