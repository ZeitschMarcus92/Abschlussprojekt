#!/usr/bin/env bash
set -euo pipefail

PROFILE="${1:-dev}"
REGISTRY="$2"; IMG_BE="$3"; IMG_FE="$4"

: "${DH_USER:?Missing DH_USER}"
: "${DH_PASS:?Missing DH_PASS}"

docker build --build-arg PROFILE="$PROFILE" -t "${IMG_BE}:${GIT_COMMIT}" backend
docker build -t "${IMG_FE}:${GIT_COMMIT}" frontend

echo "$DH_PASS" | docker login "$REGISTRY" -u "$DH_USER" --password-stdin

docker push "${IMG_BE}:${GIT_COMMIT}"
docker push "${IMG_FE}:${GIT_COMMIT}"
