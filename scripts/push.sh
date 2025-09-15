#!/usr/bin/env bash
set -euo pipefail

PROFILE="${1:-dev}"
REGISTRY="$2"
IMG_BE="$3"
IMG_FE="$4"
USER="$5"
PASS="$6"

echo "${PASS}" | docker login "${REGISTRY}" -u "${USER}" --password-stdin

docker pull maven:3.9.6-eclipse-temurin-17 || true
docker pull eclipse-temurin:17-jre || true
docker pull node:18 || true
docker pull nginx:alpine || true

docker build --build-arg PROFILE="${PROFILE}" -t "${IMG_BE}:${GIT_COMMIT}" backend
docker build -t "${IMG_FE}:${GIT_COMMIT}" frontend

docker push "${IMG_BE}:${GIT_COMMIT}"
docker push "${IMG_FE}:${GIT_COMMIT}"
docker logout "${REGISTRY}" || true
