
set -euo pipefail

PROFILE="${1:-dev}"
REGISTRY="${2:-docker.io}"
IMG_BE="${3:-}"
IMG_FE="${4:-}"


USER="${5:-${DH_USER:-}}"
PASS="${6:-${DH_PASS:-}}"

if [[ -z "${USER:-}" || -z "${PASS:-}" ]]; then
  echo "ERROR: Docker Hub USER/PASS fehlen. Übergib sie als Arg 5/6 oder setze DH_USER/DH_PASS." >&2
  exit 1
fi

docker build --build-arg PROFILE="$PROFILE" -t "${IMG_BE}:${GIT_COMMIT}" backend
docker build -t "${IMG_FE}:${GIT_COMMIT}" frontend

echo "$PASS" | docker login "$REGISTRY" -u "$USER" --password-stdin

docker push "${IMG_BE}:${GIT_COMMIT}"
docker push "${IMG_FE}:${GIT_COMMIT}"
