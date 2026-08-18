#!/bin/bash
set -euo pipefail

echo "Building frontend..."
cd frontend
npm ci
VITE_API_URL="$VITE_API_URL" npm run build
cd ..

echo "Syncing dist/ to s3://$S3_BUCKET_NAME ..."
aws s3 sync frontend/dist "s3://$S3_BUCKET_NAME" --delete