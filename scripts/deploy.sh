#!/bin/bash
set -euo pipefail

echo "$EC2_SSH_KEY" > key.pem
chmod 400 key.pem

ssh -o StrictHostKeyChecking=accept-new -i key.pem \
  "$EC2_USER@$EC2_HOST" "
    cd ~/simple-mern-todo &&
    docker compose pull $SERVICE &&
    docker compose up -d $SERVICE
  "

rm -f key.pem