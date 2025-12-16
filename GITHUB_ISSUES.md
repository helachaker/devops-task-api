# GitHub Issues Template - DevOps Task Manager API

Copy and paste these issues into your GitHub repository to organize your work.

---

## 🏗️ JOUR 1: Fondations & Setup

### Issue #1: Initialize project structure and repository
**Labels:** `setup`, `day-1`
**Assignee:** [Your Name]

**Description:**
Set up the initial project structure with proper Git repository, Python virtual environment, and basic project files.

**Tasks:**
- [ ] Create GitHub repository
- [ ] Initialize Git with .gitignore
- [ ] Create Python virtual environment
- [ ] Set up project structure (folders: tests/, k8s/, .github/)
- [ ] Create requirements.txt with Flask and dependencies
- [ ] Write initial README.md

**Acceptance Criteria:**
- Repository is created and cloned locally
- Python venv is active
- Dependencies are installed
- Basic structure is in place

---

### Issue #2: Implement Task Manager API endpoints
**Labels:** `feature`, `backend`, `day-1`
**Assignee:** [Your Name]

**Description:**
Implement the core REST API with CRUD operations for task management. Must stay under 150 lines of code.

**Tasks:**
- [ ] Implement Flask application setup
- [ ] Create SQLite database initialization
- [ ] Add POST /tasks (create task)
- [ ] Add GET /tasks (list all tasks)
- [ ] Add GET /tasks/{id} (get specific task)
- [ ] Add PUT /tasks/{id} (update task)
- [ ] Add DELETE /tasks/{id} (delete task)
- [ ] Add GET /health (health check)
- [ ] Add error handling
- [ ] Keep code under 150 lines

**Acceptance Criteria:**
- All CRUD endpoints work correctly
- Database is initialized properly
- Error handling is in place
- Code is under 150 lines

---

### Issue #3: Add unit tests with pytest
**Labels:** `testing`, `day-1`
**Assignee:** [Your Name]

**Description:**
Write comprehensive unit tests to ensure API functionality and achieve good code coverage.

**Tasks:**
- [ ] Set up pytest configuration
- [ ] Write test for health endpoint
- [ ] Write tests for CRUD operations
- [ ] Write tests for error cases (404, 400)
- [ ] Add test for metrics endpoint
- [ ] Achieve >90% code coverage
- [ ] Create tests/__init__.py

**Acceptance Criteria:**
- All tests pass
- Coverage is >90%
- Tests cover happy path and error cases

---

## 🐳 JOUR 2: Containerisation

### Issue #4: Create optimized Dockerfile
**Labels:** `docker`, `day-2`
**Assignee:** [Your Name]

**Description:**
Create a multi-stage Dockerfile for optimal image size and security.

**Tasks:**
- [ ] Create multi-stage Dockerfile (builder + runtime)
- [ ] Use Python 3.11-slim base image
- [ ] Add non-root user for security
- [ ] Add health check
- [ ] Configure Gunicorn for production
- [ ] Create .dockerignore
- [ ] Test build and run locally

**Acceptance Criteria:**
- Image builds successfully
- Image size < 150MB
- Application runs in container
- Health check works

---

### Issue #5: Setup docker-compose with observability
**Labels:** `docker`, `observability`, `day-2`
**Assignee:** [Your Name]

**Description:**
Create docker-compose.yml with API, Prometheus, and Grafana for local development.

**Tasks:**
- [ ] Create docker-compose.yml
- [ ] Add app service
- [ ] Add Prometheus service
- [ ] Add Grafana service
- [ ] Configure networking
- [ ] Add volumes for persistence
- [ ] Create prometheus.yml configuration
- [ ] Test full stack locally

**Acceptance Criteria:**
- All services start successfully
- Services can communicate
- Prometheus scrapes metrics
- Grafana is accessible

---

### Issue #6: Test local deployment with Docker
**Labels:** `docker`, `testing`, `day-2`
**Assignee:** [Your Name]

**Description:**
Validate that the containerized application works correctly and meets performance requirements.

**Tasks:**
- [ ] Build Docker image
- [ ] Run container locally
- [ ] Test all API endpoints
- [ ] Verify health checks
- [ ] Test with docker-compose
- [ ] Measure startup time
- [ ] Document Docker commands

**Acceptance Criteria:**
- Container starts in <10 seconds
- All endpoints respond correctly
- Health checks pass

---

## 🔄 JOUR 3: CI/CD Pipeline

### Issue #7: Setup GitHub Actions workflow
**Labels:** `ci-cd`, `day-3`
**Assignee:** [Your Name]

**Description:**
Create comprehensive CI/CD pipeline with GitHub Actions for automated testing, building, and deployment.

**Tasks:**
- [ ] Create .github/workflows/ci-cd.yml
- [ ] Add test job with pytest
- [ ] Add SAST job with Bandit
- [ ] Add build job for Docker
- [ ] Add container scan with Trivy
- [ ] Add DAST job with OWASP ZAP
- [ ] Configure job dependencies
- [ ] Add status badges to README

**Acceptance Criteria:**
- Pipeline runs on push/PR
- All jobs execute successfully
- Pipeline completes in <5 minutes

---

### Issue #8: Add automated tests to CI
**Labels:** `ci-cd`, `testing`, `day-3`
**Assignee:** [Your Name]

**Description:**
Integrate unit tests and coverage reporting into CI pipeline.

**Tasks:**
- [ ] Configure pytest in CI
- [ ] Add coverage reporting
- [ ] Upload coverage to Codecov (optional)
- [ ] Fail build if tests fail
- [ ] Cache pip dependencies
- [ ] Generate test artifacts

**Acceptance Criteria:**
- Tests run automatically on push
- Coverage report is generated
- Failed tests block merge

---

### Issue #9: Configure Docker image push to Docker Hub
**Labels:** `ci-cd`, `docker`, `day-3`
**Assignee:** [Your Name]

**Description:**
Automate Docker image building and publishing to Docker Hub.

**Tasks:**
- [ ] Add Docker Hub credentials to GitHub Secrets
- [ ] Configure Docker login in workflow
- [ ] Build image with proper tags
- [ ] Push to Docker Hub
- [ ] Add latest and SHA tags
- [ ] Verify image on Docker Hub

**Acceptance Criteria:**
- Image is pushed automatically
- Multiple tags are created
- Image is publicly accessible

---

## 📊 JOUR 4: Observabilité

### Issue #10: Implement Prometheus metrics
**Labels:** `observability`, `metrics`, `day-4`
**Assignee:** [Your Name]

**Description:**
Expose Prometheus metrics for monitoring request count and latency.

**Tasks:**
- [ ] Install prometheus-client
- [ ] Add /metrics endpoint
- [ ] Implement request counter (by method, endpoint, status)
- [ ] Implement latency histogram
- [ ] Test metrics endpoint
- [ ] Configure Prometheus scraping

**Acceptance Criteria:**
- /metrics endpoint returns Prometheus format
- Request count increases with API calls
- Latency is measured correctly

---

### Issue #11: Add structured logging
**Labels:** `observability`, `logging`, `day-4`
**Assignee:** [Your Name]

**Description:**
Implement structured JSON logging for all requests and errors.

**Tasks:**
- [ ] Configure Python logging
- [ ] Format logs as JSON
- [ ] Log all incoming requests
- [ ] Log all responses with latency
- [ ] Log errors with stack traces
- [ ] Test log output

**Acceptance Criteria:**
- Logs are in JSON format
- All requests are logged
- Errors include details

---

### Issue #12: Setup basic tracing
**Labels:** `observability`, `tracing`, `day-4`
**Assignee:** [Your Name]

**Description:**
Add basic request tracing to track request flow through the application.

**Tasks:**
- [ ] Add request ID to logs
- [ ] Track request start time
- [ ] Measure request duration
- [ ] Correlate related logs
- [ ] Document tracing approach

**Acceptance Criteria:**
- Each request has unique ID
- Duration is measured
- Logs are correlated

---

## 🔒 JOUR 5: Sécurité

### Issue #13: Integrate Bandit SAST scanning
**Labels:** `security`, `sast`, `day-5`
**Assignee:** [Your Name]

**Description:**
Add Bandit static security analysis to detect code vulnerabilities.

**Tasks:**
- [ ] Install Bandit
- [ ] Create .bandit configuration
- [ ] Run Bandit locally
- [ ] Add to CI pipeline
- [ ] Generate JSON report
- [ ] Fix any high/critical issues
- [ ] Upload artifacts

**Acceptance Criteria:**
- Bandit runs in CI
- Report is generated
- No critical vulnerabilities

---

### Issue #14: Add Safety dependency check
**Labels:** `security`, `dependencies`, `day-5`
**Assignee:** [Your Name]

**Description:**
Use Safety to check for known vulnerabilities in Python dependencies.

**Tasks:**
- [ ] Install Safety
- [ ] Run Safety check locally
- [ ] Add to CI pipeline
- [ ] Document any vulnerabilities
- [ ] Update vulnerable packages
- [ ] Generate report

**Acceptance Criteria:**
- Safety runs in CI
- No high/critical CVEs
- Report is available

---

### Issue #15: Setup OWASP ZAP DAST scanning
**Labels:** `security`, `dast`, `day-5`
**Assignee:** [Your Name]

**Description:**
Implement dynamic security testing with OWASP ZAP.

**Tasks:**
- [ ] Create ZAP rules configuration
- [ ] Add ZAP scan to CI
- [ ] Start app before scan
- [ ] Run baseline scan
- [ ] Review results
- [ ] Configure acceptable warnings
- [ ] Stop app after scan

**Acceptance Criteria:**
- ZAP scan runs in CI
- No critical vulnerabilities
- False positives are handled

---

## ☸️ JOUR 6: Kubernetes

### Issue #16: Create Kubernetes manifests
**Labels:** `kubernetes`, `day-6`
**Assignee:** [Your Name]

**Description:**
Write Kubernetes YAML manifests for deployment, service, and configuration.

**Tasks:**
- [ ] Create k8s/deployment.yaml
- [ ] Create k8s/service.yaml (NodePort)
- [ ] Create k8s/configmap.yaml
- [ ] Create k8s/hpa.yaml (autoscaling)
- [ ] Add resource limits
- [ ] Add health probes
- [ ] Configure replicas

**Acceptance Criteria:**
- All manifests are valid
- Resources are properly configured
- Manifests follow best practices

---

### Issue #17: Deploy to minikube/kind
**Labels:** `kubernetes`, `deployment`, `day-6`
**Assignee:** [Your Name]

**Description:**
Deploy the application to a local Kubernetes cluster.

**Tasks:**
- [ ] Start minikube/kind
- [ ] Apply all manifests
- [ ] Verify deployment
- [ ] Verify pods are running
- [ ] Test service access
- [ ] Verify health probes
- [ ] Document commands

**Acceptance Criteria:**
- All pods are running
- Service is accessible
- Application responds correctly

---

### Issue #18: Test K8s deployment and scaling
**Labels:** `kubernetes`, `testing`, `day-6`
**Assignee:** [Your Name]

**Description:**
Validate Kubernetes features like scaling, self-healing, and rolling updates.

**Tasks:**
- [ ] Test manual scaling
- [ ] Test HPA autoscaling
- [ ] Test pod self-healing (delete pod)
- [ ] Test rolling update
- [ ] Test service load balancing
- [ ] Verify resource limits
- [ ] Document findings

**Acceptance Criteria:**
- Scaling works correctly
- Pods restart automatically
- Rolling update has no downtime

---

## 📝 JOUR 7: Documentation & Présentation

### Issue #19: Write comprehensive README
**Labels:** `documentation`, `day-7`
**Assignee:** [Your Name]

**Description:**
Create professional README with all setup instructions and API documentation.

**Tasks:**
- [ ] Add project overview
- [ ] Document prerequisites
- [ ] Add quick start guide
- [ ] Document all API endpoints with examples
- [ ] Add Docker instructions
- [ ] Add Kubernetes instructions
- [ ] Add observability section
- [ ] Add security section
- [ ] Add badges (CI/CD, Docker)
- [ ] Add troubleshooting

**Acceptance Criteria:**
- README is complete and clear
- All sections are documented
- Examples work correctly

---

### Issue #20: Create final report
**Labels:** `documentation`, `day-7`
**Assignee:** [Your Name]

**Description:**
Write final report (1-2 pages) describing architecture, tools, and lessons learned.

**Tasks:**
- [ ] Describe architecture
- [ ] Justify technology choices
- [ ] Document observability implementation
- [ ] Document security measures
- [ ] Describe Kubernetes setup
- [ ] List lessons learned
- [ ] Add metrics and results
- [ ] Describe peer review experience
- [ ] Proofread

**Acceptance Criteria:**
- Report is 1-2 pages
- All sections completed
- Professional formatting

---

### Issue #21: Prepare presentation slides
**Labels:** `documentation`, `presentation`, `day-7`
**Assignee:** [Your Name]

**Description:**
Create presentation slides for 10-minute demo and Q&A.

**Tasks:**
- [ ] Create 10-12 slides
- [ ] Add architecture diagram
- [ ] Prepare demo script
- [ ] Add key metrics
- [ ] Prepare for common questions
- [ ] Practice presentation (timing)
- [ ] Prepare backup plans

**Acceptance Criteria:**
- Presentation is 10 minutes
- Demo is smooth
- Ready for Q&A

---

## 📌 Labels to Create in GitHub

Create these labels in your repository (Settings > Labels):

- `setup` - Initial setup tasks
- `feature` - New features
- `backend` - Backend development
- `testing` - Testing related
- `docker` - Docker/containerization
- `ci-cd` - CI/CD pipeline
- `observability` - Monitoring and logs
- `metrics` - Prometheus metrics
- `logging` - Logging
- `tracing` - Request tracing
- `security` - Security related
- `sast` - Static security testing
- `dast` - Dynamic security testing
- `dependencies` - Dependency management
- `kubernetes` - Kubernetes/K8s
- `deployment` - Deployment tasks
- `documentation` - Documentation
- `presentation` - Presentation prep
- `day-1` through `day-7` - Daily organization

---

## 🎯 How to Use These Issues

1. **Copy each issue** into your GitHub repository
2. **Assign yourself** to each issue
3. **Add appropriate labels** for filtering
4. **Create a Project board** with columns: To Do, In Progress, Done
5. **Move issues** as you progress
6. **Reference issues** in commits: `git commit -m "feat: add health endpoint (closes #1)"`
7. **Create PRs** that reference issues: `Closes #2`

---

## ✅ Workflow Example

```bash
# Day 1 Morning
git checkout -b feature/issue-1-setup
# Work on Issue #1
git commit -m "feat: initialize project structure (closes #1)"
git push origin feature/issue-1-setup
# Create PR, get review, merge

# Day 1 Afternoon
git checkout -b feature/issue-2-api
# Work on Issue #2
git commit -m "feat: implement CRUD endpoints (closes #2)"
# etc...
```

---

**Total: 21 Issues covering all project requirements** ✅
