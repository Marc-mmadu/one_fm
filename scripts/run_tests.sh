#!/bin/bash
set -e

echo "🧪 Starting test container..."

# Run tests using test-specific docker-compose
docker compose -f docker-compose.test.yml up --abort-on-container-exit --exit-code-from onefm

# Optionally clean up test containers afterward
docker compose -f docker-compose.test.yml down --volumes