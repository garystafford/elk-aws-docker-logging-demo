#!/bin/sh

# Deploy the Logspout portion of the ELK Demo locally
# Maintainer: Gary A. Stafford <garystafford@rochester.rr.com>

echo "\n Deploying services..."
docker-compose -f docker-compose-logspout.yml -p elk up -d

echo "\n Waiting for all services to fully start..."
sleep 15s
docker ps
docker logs elk_elk_1 --follow
