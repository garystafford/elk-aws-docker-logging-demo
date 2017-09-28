#!/bin/sh

# Deploy the ELK Demo Docker service stack
# Maintainer: Gary A. Stafford <garystafford@rochester.rr.com>

export WORKER_NODE_3='ip-172-31-5-65.ec2.internal'  # Hostname of ELK Worker Node - Change as required!
export ELK_IP='172.31.5.65' # IP address of ELK Worker Node - Change as required!
export DEPLOY_ENV='development' # name of Spring Active Profile

echo "\n Deploying stack..."
docker stack deploy --compose-file=docker-compose.yml --with-registry-auth elk-demo

echo "\n Waiting for all services to fully start..."
sleep 15s
docker service ls
