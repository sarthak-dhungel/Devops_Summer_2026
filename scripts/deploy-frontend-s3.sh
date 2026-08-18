#!/bin/bash
set -euo pipefail

FRONTEND_DIR="simple-mern-todo/simple-mern-todo/frontend"

echo "Building frontend..."
cd "$FRONTEND_DIR"
npm ci
VITE_API_URL="$VITE_API_URL" npm run build
cd - > /dev/null

echo "Syncing dist/ to s3://$S3_BUCKET_NAME ..."
aws s3 sync "$FRONTEND_DIR/dist" "s3://$S3_BUCKET_NAME" --delete