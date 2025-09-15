#!/usr/bin/env bash
set -euo pipefail
PROFILE="${1:-dev}"
mvn -P "$PROFILE" -B -DskipTests=false -f backend/pom.xml test package
if [ -d frontend ]; then
  pushd frontend >/dev/null
  npm ci || npm install
  npm test --if-present
  npm run build --if-present
  popd >/dev/null
fi
