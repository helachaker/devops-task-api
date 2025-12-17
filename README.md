# Task Manager API - DevOps Project

![CI/CD Pipeline](https://github.com/helachaker/devops-task-api/actions/workflows/ci-cd.yml/badge.svg)
![Docker Image Size](https://img.shields.io/docker/image-size/helachaker/task-manager-api/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/helachaker/task-manager-api)

> 🎯 **Projet académique DevOps** - API REST complète avec pipeline CI/CD, observabilité et sécurité intégrée

## 📊 Vue d'ensemble

**Task Manager API** est une application REST API moderne développée avec Flask, containerisée avec Docker, et déployée via un pipeline CI/CD automatisé. Ce projet démontre les meilleures pratiques DevOps incluant l'observabilité (Prometheus + Grafana), la sécurité (SAST/DAST), et l'automation complète.

### ✨ Caractéristiques principales

- 🐍 **Backend Python** : Flask + Gunicorn + SQLite
- 🐳 **Containerisation** : Docker multi-stage avec user non-root
- 🔄 **CI/CD** : GitHub Actions avec 5 jobs automatisés (tests, sécurité, build, déploiement)
- 📊 **Observabilité** : Prometheus + Grafana + Logs JSON structurés
- 🔒 **Sécurité** : SAST (Bandit), DAST, et Trivy scanning
- 📦 **Distribution** : Image publique sur Docker Hub
- 🧪 **Tests** : Pytest avec 92% de couverture de code

---

## 🚀 Démarrage rapide

### Option 1 : Docker Compose (recommandé)
```bash
# Cloner le repository
git clone https://github.com/helachaker/devops-task-api.git
cd devops-task-api

# Lancer tous les services
docker-compose up -d

# Voir les logs
docker-compose logs -f app
```

### Option 2 : Docker Hub
```bash
# Télécharger et lancer l'image
docker pull helachaker/task-manager-api:latest
docker run -d -p 5000:5000 helachaker/task-manager-api:latest
```

### Option 3 : Environnement local (développement)
```bash
# Créer un environnement virtuel
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Installer les dépendances
pip install -r requirements.txt

# Lancer l'application
python app.py
```

### 🌐 Accéder aux services

- **API** : http://localhost:5000
- **Prometheus** : http://localhost:9090
- **Grafana** : http://localhost:3000 (login: admin/admin)

---

## 📚 Documentation API

### Base URL
```
http://localhost:5000
```

### Endpoints disponibles

#### 🏥 Health Check
```bash
GET /health
```
**Réponse :**
```json
{
  "status": "healthy",
  "timestamp": "2025-12-17T10:30:00"
}
```

#### 📊 Métriques Prometheus
```bash
GET /metrics
```
Retourne les métriques au format Prometheus.

#### ➕ Créer une tâche
```bash
POST /tasks
Content-Type: application/json

{
  "title": "Finaliser le projet DevOps",
  "description": "Compléter la documentation",
  "status": "pending"
}
```
**Réponse (201) :**
```json
{
  "id": 1,
  "message": "Task created successfully"
}
```

#### 📋 Lister toutes les tâches
```bash
GET /tasks
```
**Réponse (200) :**
```json
[
  {
    "id": 1,
    "title": "Finaliser le projet DevOps",
    "description": "Compléter la documentation",
    "status": "pending",
    "created_at": "2025-12-17 10:30:00"
  }
]
```

#### 🔍 Obtenir une tâche spécifique
```bash
GET /tasks/{id}
```

#### ✏️ Modifier une tâche
```bash
PUT /tasks/{id}
Content-Type: application/json

{
  "status": "completed"
}
```

#### ❌ Supprimer une tâche
```bash
DELETE /tasks/{id}
```

### Exemples d'utilisation

**PowerShell :**
```powershell
# Créer une tâche
$headers = @{"Content-Type" = "application/json"}
$body = '{"title":"Test","description":"Demo","status":"pending"}'
Invoke-RestMethod -Uri http://localhost:5000/tasks -Method POST -Headers $headers -Body $body

# Lister les tâches
Invoke-RestMethod -Uri http://localhost:5000/tasks
```

**Bash :**
```bash
# Créer une tâche
curl -X POST http://localhost:5000/tasks \
  -H "Content-Type: application/json" \
  -d '{"title":"Test","status":"pending"}'

# Lister les tâches
curl http://localhost:5000/tasks
```

---

## 🏗️ Architecture

### Stack Docker Compose
```
┌─────────────────────────────────────┐
│       Docker Compose Stack          │
├─────────────────────────────────────┤
│  ┌──────────┐  ┌──────────────┐   │
│  │  API     │◄─┤  Prometheus  │   │
│  │  :5000   │  │  :9090       │   │
│  └──────────┘  └──────────────┘   │
│       │              ▲              │
│       │              │              │
│       │        ┌─────┴─────┐       │
│       │        │  Grafana  │       │
│       │        │  :3000    │       │
│       ▼        └───────────┘       │
│  ┌──────────┐                      │
│  │ SQLite   │                      │
│  └──────────┘                      │
└─────────────────────────────────────┘
```

### 📈 Pipeline CI/CD

Le pipeline GitHub Actions s'exécute automatiquement à chaque push sur `main` :
```
1. 🧪 Test & Code Quality (21s)
   └─ Tests unitaires avec pytest
   └─ Rapport de couverture

2. 🔒 SAST Security Scan (20s)
   └─ Bandit (analyse statique)
   └─ Safety (dépendances)

3. 🐳 Build & Push Docker (31s)
   └─ Build multi-stage
   └─ Push sur Docker Hub
   └─ Trivy vulnerability scan

4. 🔍 DAST Security Scan (13s)
   └─ Tests dynamiques de l'API

5. ✅ Deployment Notification (2s)
   └─ Confirmation du déploiement
```

**⏱️ Durée totale : ~2 minutes**

---

## 🛠️ Technologies utilisées

| Catégorie | Technologies |
|-----------|-------------|
| **Backend** | Python 3.11, Flask, Gunicorn, SQLite |
| **Containerisation** | Docker, Docker Compose |
| **CI/CD** | GitHub Actions |
| **Observabilité** | Prometheus, Grafana |
| **Sécurité** | Bandit (SAST), Trivy, DAST |
| **Tests** | Pytest, Coverage |
| **Versioning** | Git, GitHub |

---

## 📊 Observabilité

### Métriques Prometheus

L'application expose des métriques au format Prometheus sur `/metrics` :

- `api_requests_total` : Nombre total de requêtes (par méthode, endpoint, statut)
- `api_request_duration_seconds` : Histogramme de latence

**Voir les métriques :**
```bash
curl http://localhost:5000/metrics
```

### Dashboards Grafana

1. Accéder à Grafana : http://localhost:3000
2. Login : `admin` / `admin`
3. Ajouter Prometheus comme data source : `http://prometheus:9090`
4. Créer des dashboards personnalisés

**Exemples de requêtes PromQL :**
```promql
# Taux de requêtes par minute
rate(api_requests_total[1m]) * 60

# Latence moyenne
rate(api_request_duration_seconds_sum[5m]) / rate(api_request_duration_seconds_count[5m])

# Requêtes par endpoint
sum by (endpoint) (api_requests_total)
```

### Logs structurés

Tous les logs sont au format JSON :
```bash
# Docker Compose
docker-compose logs -f app

# Exemple de log
{"time":"2025-12-17 10:30:00", "level":"INFO", "message":"Response: 200 - Latency: 0.001s"}
```

---

## 🔒 Sécurité

### SAST (Static Application Security Testing)

**Bandit** analyse le code Python pour détecter les vulnérabilités :
```bash
pip install bandit
bandit -r . -f json -o bandit-report.json
```

### Scan de dépendances

**Safety** vérifie les vulnérabilités connues dans les dépendances :
```bash
pip install safety
safety check
```

### Scan de containers

**Trivy** scanne l'image Docker pour les vulnérabilités :
```bash
trivy image helachaker/task-manager-api:latest
```

### DAST (Dynamic Application Security Testing)

Tests de sécurité dynamiques sur l'application en cours d'exécution.

**Tous ces scans sont automatisés dans le pipeline CI/CD ! 🔐**

---

## 💻 Développement

### Structure du projet
```
devops-task-api/
├── .github/
│   └── workflows/
│       └── ci-cd.yml          # Pipeline GitHub Actions
├── k8s/
│   ├── deployment.yaml        # Déploiement Kubernetes
│   ├── service.yaml           # Service K8s
│   ├── configmap.yaml         # Configuration
│   └── hpa.yaml               # Auto-scaling
├── tests/
│   └── test_app.py            # Tests unitaires
├── .zap/
│   └── rules.tsv              # Règles OWASP ZAP
├── app.py                     # Application Flask (150 lignes)
├── requirements.txt           # Dépendances Python
├── Dockerfile                 # Build multi-stage
├── docker-compose.yml         # Orchestration locale
├── prometheus.yml             # Configuration Prometheus
├── .dockerignore
├── .gitignore
├── .bandit                    # Configuration Bandit
└── README.md                  # Ce fichier
```

### Lancer les tests
```bash
# Tous les tests
pytest tests/ -v

# Avec couverture
pytest tests/ --cov=app --cov-report=html

# Voir le rapport
open htmlcov/index.html  # macOS
start htmlcov/index.html  # Windows
```

### Contribuer

1. Créer une GitHub Issue
2. Créer une branche : `git checkout -b feature/ma-fonctionnalite`
3. Faire les modifications
4. Lancer les tests : `pytest tests/`
5. Commit : `git commit -m "feat: description"`
6. Push : `git push origin feature/ma-fonctionnalite`
7. Créer une Pull Request

---

## 🔄 Configuration CI/CD

### Prérequis GitHub

Pour activer le pipeline, ajouter ces secrets dans GitHub :

1. Aller sur : `Repository → Settings → Secrets → Actions`
2. Ajouter :
   - `DOCKER_USERNAME` : Votre username Docker Hub
   - `DOCKER_PASSWORD` : Votre mot de passe Docker Hub

### Déclencher le pipeline

Le pipeline se lance automatiquement :
- ✅ À chaque push sur la branche `main`
- ✅ À chaque Pull Request vers `main`

**Voir le statut** : Actions tab sur GitHub

---

## 📊 Métriques du projet

- ✅ **150 lignes** de code backend
- ✅ **12 tests** unitaires (92% coverage)
- ✅ **7 endpoints** REST API
- ✅ **3 services** Docker (API, Prometheus, Grafana)
- ✅ **5 jobs** CI/CD automatisés
- ✅ **21 GitHub Issues** organisées par jour
- ✅ **~2 minutes** pour le pipeline complet
- ✅ **208 MB** taille de l'image Docker

---

## 📖 Documentation complète

- [📘 Guide de démarrage](START_HERE.md)
- [📋 Structure du projet](PROJECT_STRUCTURE.md)
- [📝 Rapport final](FINAL_REPORT.md)
- [🎤 Guide de présentation](PRESENTATION_GUIDE.md)
- [🔧 Guide des commandes](COMMANDS.sh)

---

## 👥 Auteur

**Nom :** Hela Chaker  
**Email :** helachaker01@gmail.com  
**Projet :** DevOps Task Manager API  
**Date :** Décembre 2025  
**Institution :** ENICarthage  

---

## 📧 Contact

**Repository** : [https://github.com/helachaker/devops-task-api](https://github.com/helachaker/devops-task-api)  
**Docker Hub** : [https://hub.docker.com/r/helachaker/task-manager-api](https://hub.docker.com/r/helachaker/task-manager-api)

---

**Made with ❤️ for DevOps Learning**