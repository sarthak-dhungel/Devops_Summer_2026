#!/bin/bash
set -euo pipefail

USERNAME="sarthakdhungel"
IMAGE="sarthaktodomern"
TAG="v1"
FULL_NAME="$USERNAME/$IMAGE:$TAG"
CONTAINER="sarthaktodomern"

NETWORK="mern-network"
MONGO_CONTAINER="mongo"

KEY="$HOME/keys/sarthak.pem"
EC2_HOST="ec2-user@54.196.141.213"

echo "Deploying $FULL_NAME to $EC2_HOST ..."

ssh -o StrictHostKeyChecking=accept-new -i "$KEY" "$EC2_HOST" "
  docker network create $NETWORK 2>/dev/null || true

  docker start $MONGO_CONTAINER 2>/dev/null || docker run -d --name $MONGO_CONTAINER --network $NETWORK --restart always -v mongo-data:/data/db mongo:7

  docker pull $FULL_NAME
  docker stop $CONTAINER 2>/dev/null || true
  docker rm $CONTAINER 2>/dev/null || true
  docker run -d --name $CONTAINER \
    --network $NETWORK \
    --network-alias backend \
    -e PORT=5000 \
    -e MONGO_URI=mongodb://$MONGO_CONTAINER:27017/simple-mern-todo \
    --restart always -p 5000:5000 $FULL_NAME
"

echo "Deployed. App is live on port 5000."
