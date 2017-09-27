#!/bin/sh

export WORKER_NODE_3='ip-172-31-5-65.ec2.internal'
export DEPLOY_ENV='development'
export ELK_IP='172.31.5.65'

echo "\ndeploying stack..."
docker stack deploy --compose-file=docker-compose.yml --with-registry-auth elk-demo

echo "\nwaiting for all services to come up..."
sleep 10s
docker service ls
