# 🚀 GUIDE DE DÉMARRAGE RAPIDE

**Temps estimé : 5-10 minutes**

---

## 📋 PRÉREQUIS

Avant de commencer, assurez-vous d'avoir installé :

- ✅ **Docker Desktop** (Windows/Mac) ou Docker Engine (Linux)
- ✅ **Git** (pour cloner le repository)
- ✅ **Un navigateur web** (Chrome, Firefox, Edge, etc.)

**Optionnel :**
- Python 3.11+ (pour développement local)
- kubectl + minikube/kind (pour Kubernetes)

---

## ⚡ DÉMARRAGE RAPIDE (3 ÉTAPES)

### 1️⃣ CLONER LE PROJET
```bash
git clone https://github.com/helachaker/devops-task-api.git
cd devops-task-api
```

### 2️⃣ LANCER LES SERVICES
```bash
docker-compose up -d
```

**Attendez 30 secondes** que tous les services démarrent.

### 3️⃣ VÉRIFIER QUE ÇA FONCTIONNE

**Ouvrez votre navigateur sur :**

- 🌐 **API** : http://localhost:5000/health
- 📊 **Prometheus** : http://localhost:9090
- 📈 **Grafana** : http://localhost:3000 (login: admin/admin)

**Si vous voyez ces interfaces → ✅ TOUT FONCTIONNE !**

---

## 🧪 TESTER L'API

### Windows (PowerShell)
```powershell
# Health check
Invoke-RestMethod -Uri http://localhost:5000/health

# Créer une tâche
$headers = @{"Content-Type" = "application/json"}
$body = '{"title":"Ma premiere tache","description":"Test de l API","status":"pending"}'
Invoke-RestMethod -Uri http://localhost:5000/tasks -Method POST -Headers $headers -Body $body

# Lister toutes les tâches
Invoke-RestMethod -Uri http://localhost:5000/tasks
```

### Linux/Mac (Bash)
```bash
# Health check
curl http://localhost:5000/health

# Créer une tâche
curl -X POST http://localhost:5000/tasks \
  -H "Content-Type: application/json" \
  -d '{"title":"Ma premiere tache","description":"Test de l API","status":"pending"}'

# Lister toutes les tâches
curl http://localhost:5000/tasks
```

---

## 📊 EXPLORER GRAFANA

1. **Ouvrir Grafana** : http://localhost:3000
2. **Se connecter** : admin / admin (Skip si demandé de changer)
3. **Ajouter Prometheus comme data source** :
   - Menu → Configuration → Data Sources
   - Add data source → Prometheus
   - URL : `http://prometheus:9090`
   - Save & Test
4. **Créer un dashboard** :
   - Menu → Dashboards → New Dashboard
   - Add visualization
   - Requête : `api_requests_total`
   - Apply

**Vous verrez les métriques de l'API en temps réel ! 📈**

---

## 🛑 ARRÊTER LES SERVICES
```bash
docker-compose down
```

Pour supprimer aussi les données :
```bash
docker-compose down -v
```

---

## 🔄 OPTIONS DE DÉMARRAGE

### Option 1 : Docker Compose (RECOMMANDÉ)

**Pour qui :** Démo complète avec observabilité
```bash
docker-compose up -d
```

**Services lancés :**
- API (port 5000)
- Prometheus (port 9090)
- Grafana (port 3000)

---

### Option 2 : Docker uniquement

**Pour qui :** Juste l'API, sans monitoring
```bash
# Télécharger l'image depuis Docker Hub
docker pull helachaker/task-manager-api:latest

# Lancer le container
docker run -d -p 5000:5000 --name task-api helachaker/task-manager-api:latest

# Tester
curl http://localhost:5000/health

# Arrêter
docker stop task-api
docker rm task-api
```

---

### Option 3 : Développement local (Python)

**Pour qui :** Développeurs qui veulent modifier le code
```bash
# Créer un environnement virtuel
python -m venv venv

# Activer (Windows)
.\venv\Scripts\Activate.ps1

# Activer (Linux/Mac)
source venv/bin/activate

# Installer les dépendances
pip install -r requirements.txt

# Lancer l'application
python app.py
```

L'API sera sur http://localhost:5000

---

### Option 4 : Kubernetes

**Pour qui :** Tests de production et scaling

**Prérequis :** kubectl + minikube ou kind
```bash
# Démarrer minikube (si pas déjà fait)
minikube start

# Déployer l'application
kubectl apply -f k8s/

# Vérifier les pods
kubectl get pods

# Accéder à l'API
minikube service task-api-service --url
```

Ou avec port-forward :
```bash
kubectl port-forward service/task-api-service 8080:80
curl http://localhost:8080/health
```

---

## 📚 ENDPOINTS DISPONIBLES

### Health Check
```
GET /health
```
Retourne le statut de santé de l'API.

### Métriques Prometheus
```
GET /metrics
```
Retourne les métriques au format Prometheus.

### Liste des tâches
```
GET /tasks
```
Retourne toutes les tâches.

### Obtenir une tâche
```
GET /tasks/{id}
```
Retourne une tâche spécifique.

### Créer une tâche
```
POST /tasks
Content-Type: application/json

{
  "title": "Titre de la tâche",
  "description": "Description optionnelle",
  "status": "pending"
}
```

### Modifier une tâche
```
PUT /tasks/{id}
Content-Type: application/json

{
  "title": "Nouveau titre",
  "status": "completed"
}
```

### Supprimer une tâche
```
DELETE /tasks/{id}
```

---

## 🔍 EXPLORER LE MONITORING

### Prometheus (http://localhost:9090)

**Requêtes utiles :**
```promql
# Nombre total de requêtes
api_requests_total

# Taux de requêtes par minute
rate(api_requests_total[1m]) * 60

# Latence moyenne
rate(api_request_duration_seconds_sum[5m]) / rate(api_request_duration_seconds_count[5m])

# Requêtes par endpoint
sum by (endpoint) (api_requests_total)
```

### Grafana (http://localhost:3000)

1. Ajouter Prometheus comme data source
2. Créer des panels avec les requêtes ci-dessus
3. Générer du trafic avec les tests API
4. Observer les graphiques en temps réel

---

## 🧪 LANCER LES TESTS
```bash
# Installer pytest (si environnement local)
pip install pytest pytest-cov

# Lancer tous les tests
pytest tests/ -v

# Avec couverture de code
pytest tests/ --cov=app --cov-report=html

# Voir le rapport HTML
open htmlcov/index.html  # Mac
start htmlcov/index.html # Windows
```

---

## 🔒 SCANS DE SÉCURITÉ
```bash
# Analyse statique avec Bandit
pip install bandit
bandit -r . -f json -o bandit-report.json

# Vérification des dépendances
pip install safety
safety check

# Scan de l'image Docker (nécessite Trivy)
trivy image helachaker/task-manager-api:latest
```

---

## 📖 DOCUMENTATION COMPLÈTE

Pour aller plus loin :

- **README.md** - Documentation complète du projet
- **PRESENTATION_GUIDE.md** - Guide pour la présentation
- **FINAL_REPORT.md** - Rapport technique détaillé
- **PROJECT_STRUCTURE.md** - Structure du projet
- **COMMANDS.sh** - Toutes les commandes en un fichier

---

## 🆘 DÉPANNAGE

### Les containers ne démarrent pas
```bash
# Voir les logs d'erreur
docker-compose logs

# Reconstruire les images
docker-compose build --no-cache
docker-compose up -d
```

### L'API ne répond pas
```bash
# Vérifier que le container tourne
docker ps | grep task-api

# Voir les logs
docker-compose logs app

# Redémarrer le service
docker-compose restart app
```

### Port déjà utilisé

Si les ports 5000, 9090 ou 3000 sont déjà utilisés :
```bash
# Modifier les ports dans docker-compose.yml
# Par exemple : "5001:5000" au lieu de "5000:5000"
```

### Kubernetes pods en erreur
```bash
# Détails du pod
kubectl describe pod <nom-du-pod>

# Logs du pod
kubectl logs <nom-du-pod>

# Redémarrer le déploiement
kubectl rollout restart deployment/task-api
```

---

## 💡 CONSEILS

### Pour une démo rapide

1. Lancer Docker Compose
2. Ouvrir les 3 interfaces (API, Prometheus, Grafana)
3. Créer quelques tâches via l'API
4. Montrer les métriques dans Grafana

### Pour du développement

1. Utiliser l'environnement Python local
2. Modifier `app.py`
3. Relancer `python app.py`
4. Les changements sont immédiats

### Pour tester la production

1. Déployer sur Kubernetes
2. Tester le scaling : `kubectl scale deployment task-api --replicas=5`
3. Observer le comportement avec HPA

---

## ⏱️ TEMPS ESTIMÉS

| Action | Durée |
|--------|-------|
| Clone + docker-compose up | 2-3 min |
| Premier test de l'API | 1 min |
| Configuration Grafana | 5 min |
| Tests unitaires | 2 min |
| Déploiement Kubernetes | 5 min |

**Total pour tout essayer : ~15-20 minutes**

---

## 🎯 PROCHAINES ÉTAPES

Maintenant que le projet tourne :

1. **Explorer l'API** - Tester tous les endpoints
2. **Créer des dashboards Grafana** - Visualiser les métriques
3. **Lire la documentation** - README.md et autres guides
4. **Tester Kubernetes** - Scaling et auto-healing
5. **Modifier le code** - Ajouter vos propres features

---

## 🌟 PROJET PRODUCTION-READY

Ce projet démontre :

✅ Architecture microservices (API + monitoring)  
✅ Containerisation avec Docker  
✅ Orchestration avec Docker Compose et Kubernetes  
✅ Observabilité avec Prometheus et Grafana  
✅ CI/CD avec GitHub Actions  
✅ Sécurité avec scans automatiques  
✅ Tests automatisés (92% coverage)  
✅ Documentation complète  

---

## 📧 LIENS UTILES

- **Repository GitHub** : https://github.com/helachaker/devops-task-api
- **Docker Hub** : https://hub.docker.com/r/helachaker/task-manager-api
- **Pipeline CI/CD** : https://github.com/helachaker/devops-task-api/actions

---

**🚀 Bon démarrage et amusez-vous bien !**

*En cas de problème, consultez README.md ou les autres guides.*