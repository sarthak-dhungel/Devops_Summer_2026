#!/bin/bash
set -euo pipefail

USERNAME="sarthakdhungel"
IMAGE="sarthaktodo-frontend"
TAG="v1"
FULL_NAME="$USERNAME/$IMAGE:$TAG"

echo "Building $FULL_NAME ..."
docker build -t "$FULL_NAME" .

echo "Pushing $FULL_NAME ..."
docker push "$FULL_NAME"

echo "Done. Image is live on Docker Hub."
