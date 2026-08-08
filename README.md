# DevOps E-Commerce Platform

Cloud-ready DevOps E-Commerce platform built with ASP.NET Core, PostgreSQL, Docker, Kubernetes, Helm and GitHub Actions.

The project demonstrates a complete DevOps workflow, from application development and containerization to Kubernetes deployment, CI/CD automation and observability.

## Architecture

The platform includes:

* ASP.NET Core backend
* React frontend
* PostgreSQL database
* Docker containerization
* Kubernetes deployment
* Helm charts
* GitHub Actions CI/CD
* GitHub Container Registry (GHCR)
* Terraform infrastructure
* Ansible automation
* Prometheus & Grafana monitoring
* Loki centralized logging

## Project Structure

```text
devops-ecommerce-platform/
├── .github/
│   └── workflows/
│       ├── backend-ci.yml
│       ├── frontend-ci.yml
│       ├── docker-build.yml
│       └── helm-cd.yml
│
├── helm/
│   └── ecommerce/
│
├── kubernetes/
│   ├── backend/
│   ├── frontend/
│   └── postgres/
│
├── monitoring/
├── terraform/
├── ansible/
├── scripts/
├── docs/
├── screenshots/
│
└── src/
    ├── backend/
    └── frontend/
```

## Technologies

| Category               | Technology                       |
| ---------------------- | -------------------------------- |
| Backend                | ASP.NET Core / .NET 8            |
| Frontend               | React / Vite                     |
| Database               | PostgreSQL 16                    |
| Containerization       | Docker                           |
| Orchestration          | Kubernetes                       |
| Package Management     | Helm                             |
| CI/CD                  | GitHub Actions                   |
| Container Registry     | GitHub Container Registry (GHCR) |
| Infrastructure as Code | Terraform                        |
| Automation             | Ansible                          |
| Monitoring             | Prometheus / Grafana             |
| Logging                | Loki                             |
| Local Kubernetes       | Minikube                         |

## CI/CD Pipeline

The project uses GitHub Actions to automate continuous integration and container image delivery.

### Backend CI

The backend pipeline validates the ASP.NET Core application by:

* Restoring dependencies
* Building the application
* Running backend validation

Workflow:

```text
Backend source code
        ↓
Backend CI
        ↓
Restore
        ↓
Build
        ↓
Validation
```

### Frontend CI

The frontend pipeline validates the React application by:

* Installing dependencies
* Building the frontend
* Running frontend validation

Workflow:

```text
Frontend source code
        ↓
Frontend CI
        ↓
Install dependencies
        ↓
Build
        ↓
Validation
```

### Docker Build & Push

After the application validation, Docker images are built and published to GitHub Container Registry.

Backend image:

```text
ghcr.io/nguefy/devops-ecommerce-platform/backend:latest
```

Frontend image:

```text
ghcr.io/nguefy/devops-ecommerce-platform/frontend:latest
```

The pipeline also publishes images using the Git commit SHA as a tag.

Example:

```text
ghcr.io/nguefy/devops-ecommerce-platform/backend:<git-sha>
ghcr.io/nguefy/devops-ecommerce-platform/frontend:<git-sha>
```

This provides both a convenient `latest` tag and an immutable commit-based image reference.

### Helm CD

The Helm CD workflow validates the Kubernetes deployment configuration.

It performs:

```text
helm lint
      ↓
helm template
```

The Helm chart references the images published to GHCR:

```yaml
backend:
  image:
    repository: ghcr.io/nguefy/devops-ecommerce-platform/backend
    tag: latest
    pullPolicy: Always

frontend:
  image:
    repository: ghcr.io/nguefy/devops-ecommerce-platform/frontend
    tag: latest
    pullPolicy: Always
```

This ensures that Helm no longer depends on locally built images.

## CI/CD Flow

The complete CI/CD flow is:

```text
Developer
    │
    ↓
Git Push
    │
    ├───────────────┐
    ↓               ↓
Backend CI      Frontend CI
    │               │
    └───────┬───────┘
            ↓
     Docker Build
            ↓
     Push to GHCR
            ↓
      Helm Validation
            │
            ├── helm lint
            └── helm template
```

## Kubernetes

The application is deployed on Kubernetes with separate components for:

* Backend
* Frontend
* PostgreSQL

Helm manages the Kubernetes resources and provides configurable values for:

* Replica counts
* Container images
* Services
* Resource requests and limits
* PostgreSQL storage
* Health probes

The backend includes:

* Readiness probe
* Liveness probe
* `/health` endpoint

## Observability

The platform includes an observability stack based on:

* Prometheus for metrics
* Grafana for visualization
* Loki for centralized logs

The goal is to provide visibility into application and Kubernetes workloads.

## Infrastructure as Code

The project also includes:

### Terraform

Terraform is used to define cloud infrastructure in a reproducible and version-controlled way.

### Ansible

Ansible is used for configuration management and automation.

## Validation Status

The CI/CD implementation has been validated successfully.

| Component                     | Status     |
| ----------------------------- | ---------- |
| Backend CI                    | ✅ Passed   |
| Frontend CI                   | ✅ Passed   |
| Docker Build                  | ✅ Passed   |
| Backend image pushed to GHCR  | ✅ Passed   |
| Frontend image pushed to GHCR | ✅ Passed   |
| Backend GHCR image pull       | ✅ Passed   |
| Frontend GHCR image pull      | ✅ Passed   |
| Helm lint                     | ✅ Passed   |
| Helm template                 | ✅ Passed   |
| Helm references GHCR images   | ✅ Verified |
| Helm CD workflow              | ✅ Passed   |

## GHCR Image Validation

The published images were successfully pulled from GHCR.

Backend:

```text
ghcr.io/nguefy/devops-ecommerce-platform/backend:latest
```

Frontend:

```text
ghcr.io/nguefy/devops-ecommerce-platform/frontend:latest
```

This confirms that the images produced by the Docker pipeline are available from the container registry and that Helm references the same GHCR repositories.

## Current Status

The project currently demonstrates:

* Application containerization
* Docker Compose development environment
* Kubernetes deployment
* Helm-based Kubernetes configuration
* Automated backend CI
* Automated frontend CI
* Docker image build and publishing
* GHCR container registry
* Helm configuration validation
* Prometheus/Grafana observability
* Loki centralized logging
* Infrastructure as Code foundations

## Future Improvements

Potential next improvements include:

* Deploying Helm automatically to a Kubernetes cluster
* Using Git SHA or immutable image digests instead of `latest`
* Adding automated integration tests
* Adding security scanning for Docker images
* Adding Kubernetes security policies
* Deploying the infrastructure to Azure
* Adding production-grade secrets management
* Improving observability dashboards and alerts
