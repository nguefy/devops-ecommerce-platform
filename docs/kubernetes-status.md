# Kubernetes Status - Sprint 5

Date: 2026-08-06

## Cluster

```bash
kubectl get nodes
kubectl get all # All Resources 
kubectl get pvc # Persitent Volumes
kubectl get endpoints # Services endpoints#



## Architecture deployed

Minikube

Frontend (React + Nginx)
        |
        | /api
        v
Backend (ASP.NET Core)
        |
        v
PostgreSQL


# Validation tests

Backend health:
curl http://backend:8080/health

API products:
curl http://backend:8080/api/products
