#!/usr/bin/env bash
set -euo pipefail
ENV="${1:?dev|prod}"; BE_TAG="${2:?}"; FE_TAG="${3:?}"
case "$ENV" in
  dev)  NS="marcuszeitsch-dev";  DIR="k8s/dev"  ;;
  prod) NS="marcuszeitsch-prod"; DIR="k8s/prod" ;;
  *) echo "Usage: $0 dev|prod <be-tag> <fe-tag>"; exit 1 ;;
esac
kubectl apply -f "$DIR"
kubectl -n "$NS" set image deployment/app-backend  app-backend="$BE_TAG"
kubectl -n "$NS" set image deployment/app-frontend app-frontend="$FE_TAG"
kubectl -n "$NS" rollout status deployment/app-backend
kubectl -n "$NS" rollout status deployment/app-frontend
