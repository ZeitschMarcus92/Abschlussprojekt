# Kukuk DevOps – Repo

Enthält: dein Code (backend/frontend) + schlanke CI/CD (Jenkins + Scripts) + K8s-Manifeste (dev/prod).

## Jenkins Credentials
REGISTRY_URL (Secret Text), REGISTRY_CREDS (Username/Password), KUBECONFIG_DEV/PROD (Secret file).

## Pipeline
Parameter TARGET=dev|prod, commit-genaue Images, Dev-Deploy + Promotion zu Prod.

## Quickstart
cd backend && mvn -P dev clean package
cd ../frontend && npm ci && npm run build
