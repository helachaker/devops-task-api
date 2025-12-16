# 📁 Structure du Projet - Vue d'Ensemble

Ce document décrit tous les fichiers du projet et leur rôle.

## 🌳 Arborescence Complète

```
devops-task-api/
│
├── 📄 app.py                          # Application Flask principale (140 lignes)
├── 📄 requirements.txt                # Dépendances Python
├── 📄 Dockerfile                      # Image Docker multi-stage
├── 📄 docker-compose.yml              # Stack complète (API + observabilité)
├── 📄 prometheus.yml                  # Configuration Prometheus
├── 📄 pytest.ini                      # Configuration pytest
├── 📄 LICENSE                         # Licence MIT
│
├── 📄 .gitignore                      # Fichiers à ignorer par Git
├── 📄 .dockerignore                   # Fichiers à ignorer par Docker
├── 📄 .bandit                         # Configuration Bandit (SAST)
│
├── 📂 .github/
│   └── 📂 workflows/
│       └── 📄 ci-cd.yml               # Pipeline GitHub Actions
│
├── 📂 k8s/                            # Manifests Kubernetes
│   ├── 📄 deployment.yaml             # Deployment + Service
│   ├── 📄 configmap.yaml              # Configuration
│   └── 📄 hpa.yaml                    # Horizontal Pod Autoscaler
│
├── 📂 tests/                          # Tests unitaires
│   ├── 📄 __init__.py
│   └── 📄 test_app.py                 # Tests complets de l'API
│
├── 📂 .zap/                           # Configuration OWASP ZAP
│   └── 📄 rules.tsv                   # Règles DAST
│
├── 📄 README.md                       # Documentation principale ⭐
├── 📄 FINAL_REPORT.md                 # Template de rapport final
├── 📄 PRESENTATION_GUIDE.md           # Guide de présentation
├── 📄 GITHUB_ISSUES.md                # Templates des 21 issues
├── 📄 PEER_REVIEW_GUIDE.md            # Guide de peer review
├── 📄 COMMANDS.sh                     # Toutes les commandes utiles
└── 📄 quickstart.sh                   # Script de démarrage rapide
```

---

## 📋 Description Détaillée des Fichiers

### **Core Application** 🎯

#### `app.py` (140 lignes)
**Rôle:** Application Flask principale avec API REST complète

**Contenu:**
- ✅ 6 endpoints REST (health, metrics, CRUD tasks)
- ✅ Métriques Prometheus (request_count, latency)
- ✅ Logs structurés JSON
- ✅ Gestion d'erreurs complète
- ✅ Base SQLite avec initialisation auto

**Technologies:**
- Flask 3.0.0
- prometheus-client
- SQLite3

---

#### `requirements.txt`
**Rôle:** Liste de toutes les dépendances Python

**Packages:**
```
Flask==3.0.0
prometheus-client==0.19.0
pytest==7.4.3
pytest-cov==4.1.0
requests==2.31.0
gunicorn==21.2.0
```

---

### **Containerisation** 🐳

#### `Dockerfile`
**Rôle:** Image Docker optimisée multi-stage

**Caractéristiques:**
- ✅ Multi-stage build (builder + runtime)
- ✅ Python 3.11-slim (image finale ~95MB)
- ✅ Utilisateur non-root
- ✅ Health check intégré
- ✅ Gunicorn pour production

---

#### `docker-compose.yml`
**Rôle:** Orchestration de la stack complète

**Services:**
1. **app** - API Task Manager
2. **prometheus** - Collecte de métriques
3. **grafana** - Visualisation

**Features:**
- Networking automatique
- Volumes persistants
- Health checks

---

#### `prometheus.yml`
**Rôle:** Configuration de Prometheus

**Cibles:**
- API Task Manager (scrape toutes les 10s)
- Endpoint: /metrics

---

### **CI/CD & Automatisation** ⚙️

#### `.github/workflows/ci-cd.yml`
**Rôle:** Pipeline CI/CD complet avec GitHub Actions

**Jobs:**
1. **test** - Tests unitaires + couverture
2. **sast** - Scans de sécurité statiques (Bandit, Safety)
3. **build** - Build et push Docker image
4. **dast** - Scan de sécurité dynamique (OWASP ZAP)
5. **notify** - Notification de déploiement

**Triggers:**
- Push sur main/develop
- Pull Requests

---

### **Kubernetes** ☸️

#### `k8s/deployment.yaml`
**Rôle:** Déploiement Kubernetes de l'API

**Composants:**
- **Deployment**: 3 replicas, health probes, resource limits
- **Service**: NodePort (30080) pour accès externe

---

#### `k8s/configmap.yaml`
**Rôle:** Configuration centralisée pour les pods

**Variables:**
- DB_PATH
- LOG_LEVEL

---

#### `k8s/hpa.yaml`
**Rôle:** Auto-scaling basé sur CPU/Memory

**Configuration:**
- Min: 2 pods
- Max: 10 pods
- Target CPU: 70%
- Target Memory: 80%

---

### **Tests** 🧪

#### `tests/test_app.py`
**Rôle:** Tests unitaires complets de l'API

**Tests (12):**
- ✅ Health check
- ✅ Metrics endpoint
- ✅ CRUD operations (create, read, update, delete)
- ✅ Cas d'erreur (404, 400)
- ✅ Validation des données

**Couverture:** >90%

---

#### `pytest.ini`
**Rôle:** Configuration pytest

**Options:**
- Verbosité
- Couverture automatique
- Rapports HTML

---

### **Sécurité** 🔒

#### `.bandit`
**Rôle:** Configuration Bandit pour SAST

**Settings:**
- Exclusions: tests/, venv/
- Skip certains checks non pertinents

---

#### `.zap/rules.tsv`
**Rôle:** Configuration OWASP ZAP pour DAST

**Règles:**
- Ignore faux positifs
- Seuils d'alerte personnalisés

---

### **Documentation** 📚

#### `README.md` ⭐ **LE PLUS IMPORTANT**
**Rôle:** Documentation complète du projet

**Sections:**
1. Introduction et features
2. Tech stack
3. Quick start
4. Documentation API complète avec exemples curl
5. Instructions Docker
6. Instructions Kubernetes
7. Observabilité (metrics, logs, tracing)
8. Sécurité (SAST, DAST)
9. Guide de développement
10. CI/CD pipeline

**Longueur:** ~800 lignes très détaillées

---

#### `FINAL_REPORT.md`
**Rôle:** Template pour le rapport final académique (1-2 pages)

**Structure:**
1. Vue d'ensemble
2. Architecture et choix technologiques
3. Implémentation par exigence (20%, 15%, 10%...)
4. Résultats et métriques
5. Leçons apprises
6. Peer review
7. Conclusion

---

#### `PRESENTATION_GUIDE.md`
**Rôle:** Guide complet pour la présentation de 10 minutes

**Contenu:**
- Structure slide par slide
- Script de démo minute par minute
- Réponses aux questions fréquentes
- Checklist avant présentation
- Conseils pour impressionner

---

#### `GITHUB_ISSUES.md`
**Rôle:** Templates des 21 GitHub Issues

**Organisation:**
- 21 issues couvrant les 7 jours
- Labels suggérés
- Acceptance criteria
- Workflow exemple

---

#### `PEER_REVIEW_GUIDE.md`
**Rôle:** Guide exhaustif pour donner/recevoir des peer reviews

**Sections:**
1. Checklist du reviewer
2. Comment rédiger des commentaires de qualité
3. Exemples de bons/mauvais commentaires
4. Workflow de peer review
5. Conseils pour auteur et reviewer
6. Grille d'évaluation

---

### **Scripts Utilitaires** 🛠️

#### `COMMANDS.sh`
**Rôle:** Collection de toutes les commandes utiles

**Sections:**
1. Initial setup
2. Local testing
3. Docker operations
4. Docker Compose
5. Security scans
6. Kubernetes deployment
7. GitHub Actions setup
8. Monitoring & observability
9. API testing examples
10. Cleanup
11. Troubleshooting

**Usage:** Copier-coller les commandes au besoin

---

#### `quickstart.sh` ⚡
**Rôle:** Script interactif de démarrage rapide

**Options:**
1. Run with Docker Compose (recommandé)
2. Run locally with Python
3. Run tests only
4. Deploy to Kubernetes
5. Setup for development

**Features:**
- Vérifie les prérequis
- Installation automatique
- Tests de santé

**Usage:**
```bash
chmod +x quickstart.sh
./quickstart.sh
```

---

### **Configuration** ⚙️

#### `.gitignore`
**Rôle:** Fichiers à ignorer par Git

**Exclusions:**
- Python: `__pycache__`, venv, *.pyc
- Tests: .pytest_cache, coverage
- IDE: .vscode, .idea
- Database: *.db
- Secrets: .env

---

#### `.dockerignore`
**Rôle:** Fichiers à exclure du build Docker

**Exclusions:**
- .git, .github
- Tests
- Documentation
- k8s/
- Docker files

**Impact:** Image plus petite et build plus rapide

---

#### `LICENSE`
**Rôle:** Licence MIT du projet

---

## 📊 Statistiques du Projet

| Métrique | Valeur |
|----------|--------|
| **Fichiers totaux** | 23 fichiers |
| **Lignes de code (app.py)** | 140 lignes |
| **Lignes de tests** | 120 lignes |
| **Lignes de documentation** | ~3000+ lignes |
| **Endpoints API** | 6 |
| **Tests unitaires** | 12 |
| **GitHub Issues** | 21 |
| **Jobs CI/CD** | 5 |
| **Kubernetes manifests** | 3 |

---

## 🎯 Fichiers Essentiels à Comprendre

Si vous n'avez le temps de lire que 5 fichiers :

1. **README.md** ⭐⭐⭐ - Documentation complète
2. **app.py** ⭐⭐⭐ - Code principal de l'API
3. **.github/workflows/ci-cd.yml** ⭐⭐ - Pipeline CI/CD
4. **k8s/deployment.yaml** ⭐⭐ - Déploiement K8s
5. **PRESENTATION_GUIDE.md** ⭐ - Pour la présentation

---

## 🚀 Ordre de Lecture Recommandé

Pour les nouveaux utilisateurs :

1. 📖 **README.md** - Vue d'ensemble et quick start
2. 🏗️ **PROJECT_STRUCTURE.md** (ce fichier) - Comprendre l'architecture
3. 🐍 **app.py** - Code de l'application
4. 🧪 **tests/test_app.py** - Tests unitaires
5. 🐳 **Dockerfile** + **docker-compose.yml** - Containerisation
6. ⚙️ **.github/workflows/ci-cd.yml** - Pipeline CI/CD
7. ☸️ **k8s/deployment.yaml** - Kubernetes
8. 📝 **COMMANDS.sh** - Commandes pratiques
9. 🎤 **PRESENTATION_GUIDE.md** - Préparation présentation
10. 📊 **FINAL_REPORT.md** - Rédaction du rapport

---

## 💡 Conseils d'Utilisation

### **Pour démarrer rapidement:**
```bash
chmod +x quickstart.sh
./quickstart.sh
# Choisir option 1 (Docker Compose)
```

### **Pour développer:**
1. Lire README.md section "Development"
2. Utiliser COMMANDS.sh comme référence
3. Suivre GITHUB_ISSUES.md pour organiser le travail

### **Pour la présentation:**
1. Lire PRESENTATION_GUIDE.md en entier
2. Préparer la démo avec quickstart.sh
3. Tester une fois avant le jour J

### **Pour le rapport:**
1. Utiliser FINAL_REPORT.md comme template
2. Remplir les métriques réelles de votre projet
3. Ajouter vos propres apprentissages

---

## 📞 Besoin d'Aide ?

**Documentation:**
- README.md pour usage général
- COMMANDS.sh pour commandes spécifiques
- PRESENTATION_GUIDE.md pour questions/réponses

**Debugging:**
- Section Troubleshooting dans COMMANDS.sh
- Logs: `docker-compose logs -f app`
- Tests: `pytest tests/ -v`

---

## ✅ Validation du Projet

Avant de soumettre, vérifiez :

- [ ] Tous les tests passent: `pytest tests/`
- [ ] Pipeline CI/CD est vert sur GitHub
- [ ] Docker image est sur Docker Hub
- [ ] Kubernetes deployment fonctionne
- [ ] README.md est à jour
- [ ] Rapport final est complété
- [ ] Présentation est prête

---

**🎉 Vous avez maintenant un projet DevOps complet et professionnel !**
