#!/bin/sh

# export MANAGER_NODE=34.206.1.241
# ssh -i "~/.ssh/elk-demo" -NL localhost:2375:/var/run/docker.sock docker@${MANAGER_NODE}
# export DOCKER_HOST=tcp://127.0.0.1:2375


export WORKER_NODE_3='ip-172-31-5-65.ec2.internal'
export DEPLOY_ENV='development'
export ELK_IP='172.31.5.65'

echo "\ndeploying stack..."
docker stack deploy --compose-file=docker-compose.yml --with-registry-auth elk-demo

echo "\nwaiting for all services to come up..."
sleep 10s
docker service ls
