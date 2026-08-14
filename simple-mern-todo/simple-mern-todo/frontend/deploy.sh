#!/bin/bash
set -euo pipefail

USERNAME="sarthakdhungel"
IMAGE="sarthaktodo-frontend"
TAG="v1"
FULL_NAME="$USERNAME/$IMAGE:$TAG"
CONTAINER="sarthaktodo-frontend"

NETWORK="mern-network"

KEY="$HOME/keys/sarthak.pem"
EC2_HOST="ec2-user@54.196.141.213"

echo "Deploying $FULL_NAME to $EC2_HOST ..."

ssh -o StrictHostKeyChecking=accept-new -i "$KEY" "$EC2_HOST" "
  docker pull $FULL_NAME
  docker stop $CONTAINER 2>/dev/null || true
  docker rm $CONTAINER 2>/dev/null || true
  docker run -d --name $CONTAINER \
    --network $NETWORK \
    --restart always -p 3000:80 $FULL_NAME
"

echo "Deployed. App is live on port 3000."
