# Rapport Final - Projet DevOps Task Manager API

**Auteur :** Hela Chaker | **Email :** helachaker01@gmail.com  
**Institution :** ENICarthage | **Date :** Décembre 2025  
**Repository :** https://github.com/helachaker/devops-task-api  

---

## 1. Architecture et Outils

### Architecture Globale
Le projet implémente une architecture microservices complète avec séparation des préoccupations : une API REST Python/Flask (150 lignes), containerisée avec Docker, orchestrée par Kubernetes, et monitorée par une stack d'observabilité Prometheus/Grafana.

### Stack Technique
**Backend :** Python 3.11 + Flask 3.0.0 | **Serveur :** Gunicorn (2 workers)  
**Base de données :** SQLite (persistance locale)  
**Containerisation :** Docker multi-stage (image 208 MB, user non-root)  
**Orchestration :** Docker Compose (dev) + Kubernetes kind (production)  
**CI/CD :** GitHub Actions (5 jobs automatisés : test, sast, build, dast, notify)  
**Registry :** Docker Hub (helachaker/task-manager-api, 98+ pulls)  
**Monitoring :** Prometheus 2.x + Grafana 10.x  
**Sécurité :** Bandit (SAST), Safety (dépendances), Trivy (containers)  

### Workflow DevOps
```
Code → Git Push → GitHub Actions → [Tests + Scans] → Docker Build → 
Push Docker Hub → Déploiement K8s → Monitoring Prometheus/Grafana
```

---

## 2. Observabilité

### Métriques Prometheus
Deux métriques custom exposées sur `/metrics` :
- **api_requests_total** (Counter) : Total des requêtes par endpoint/méthode/statut
- **api_request_duration_seconds** (Histogram) : Latence des requêtes avec buckets 5ms-10s

**Configuration :** Scraping toutes les 10s, retention 15 jours. Résultats observés : 59 requêtes /metrics, latence P95 < 5ms.

### Logs Structurés
Format JSON systématique : `{"time":"...", "level":"...", "message":"..."}`. Permet agrégation et parsing automatique (compatible ELK, Splunk).

### Dashboards Grafana
Configuration de data source Prometheus (`http://prometheus:9090`), création de panels temps réel pour visualiser taux de requêtes, latence moyenne, et distribution par endpoint.

---

## 3. Sécurité

### Analyse Statique (SAST)
**Bandit :** Scan du code Python → 0 vulnérabilités critiques/hautes  
**Safety :** Vérification des dépendances → 0 CVEs connues  
**Résultat :** Pipeline de sécurité 100% vert dans CI/CD

### Analyse Dynamique (DAST)
Tests de l'API en cours d'exécution : validation des endpoints, codes HTTP, gestion d'erreurs. Intégré dans le job `dast` du pipeline.

### Container Security
**Trivy :** Scan de l'image Docker → 0 vulnérabilités critiques/hautes  
**Best practices :** User non-root (appuser UID 1000), multi-stage build, secrets GitHub pour credentials Docker Hub

---

## 4. Kubernetes Setup

### Manifests Déployés
**Deployment :** 3 replicas (scalé dynamiquement 2-10), resource limits (CPU 200m, Memory 256Mi), health probes (liveness/readiness sur `/health`)  
**Service :** NodePort type, port 80→5000, nodePort 30080  
**ConfigMap :** Configuration centralisée (DB_PATH, LOG_LEVEL)  
**HPA :** Auto-scaling basé sur CPU (70%) et Memory (80%), min 2 - max 10 pods

### Résultats Validés
- Déploiement sur cluster kind (enicarthage) : 2 pods Running
- Test de scaling : 2→5→2 pods sans downtime
- API accessible via port-forward (kubectl port-forward service/task-api-service 8080:80)
- Health checks automatiques toutes les 5-10s

---

## 5. Leçons Apprises

### Défis Techniques Surmontés

**1. Permissions SQLite dans Docker**  
*Problème :* User non-root sans accès écriture sur `/data`  
*Solution :* `RUN mkdir -p /data && chown -R appuser:appuser /data` dans Dockerfile  
*Apprentissage :* Toujours vérifier les permissions lors de l'utilisation d'users non-root

**2. Content-Type Prometheus**  
*Problème :* Prometheus rejetait `/metrics` (recevait text/html au lieu de text/plain)  
*Solution :* Spécifier explicitement `mimetype='text/plain; version=0.0.4'` dans Flask Response  
*Apprentissage :* Les outils de monitoring ont des attentes strictes sur les formats

**3. Actions GitHub Dépréciées**  
*Problème :* Pipeline échouait avec actions v3 dépréciées  
*Solution :* Migration vers v4 (actions/cache, upload-artifact, codecov)  
*Apprentissage :* Maintenir la veille technologique sur les dépendances du pipeline

### Compétences Acquises

**Techniques :** Maîtrise de Docker multi-stage, GitHub Actions YAML, Kubernetes manifests, PromQL, métriques applicatives  
**Méthodologiques :** Infrastructure as Code, shift-left security, observabilité dès la conception  
**DevOps :** Automation complète (commit→production en 2 min), zero-downtime deployment, auto-scaling production-grade

---

## 6. Résultats et Métriques

| Composant | Métrique | Résultat |
|-----------|----------|----------|
| **Code** | Lignes app.py | 150 (exactement comme requis) |
| **Tests** | Couverture | 92% (12 tests unitaires) |
| **CI/CD** | Durée pipeline | ~2 minutes (5 jobs) |
| **Docker** | Taille image | 208 MB (optimisée multi-stage) |
| **K8s** | Pods déployés | 2-10 (auto-scaling validé) |
| **API** | Latence P95 | < 5ms |
| **Sécurité** | Vulnérabilités | 0 critical/high |
| **Docker Hub** | Pulls | 98+ (image publique) |

**Pipeline CI/CD :** 100% opérationnel (dernier run : 17 déc., 17h17 GMT+1, tous jobs verts)  
**Kubernetes :** Scaling testé avec succès (2→5 pods, puis 5→2 sans interruption de service)

---

## 7. Conclusion

Ce projet démontre la transformation d'une API REST simple (150 lignes) en un système production-ready complet avec automation DevOps intégrale. Tous les objectifs ont été atteints : backend fonctionnel, pipeline CI/CD automatisé, observabilité temps réel, sécurité multi-niveaux, et orchestration Kubernetes avec auto-scaling. Le projet est déployable immédiatement en production et constitue un portfolio technique solide démontrant la maîtrise des pratiques DevOps modernes.

**Perspectives :** Déploiement cloud (AWS EKS/GCP GKE), migration vers PostgreSQL, ajout d'authentification JWT, distributed tracing avec Jaeger.

---

**Repository :** https://github.com/helachaker/devops-task-api  
**Docker Hub :** https://hub.docker.com/r/helachaker/task-manager-api  
**CI/CD Pipeline :** https://github.com/helachaker/devops-task-api/actions