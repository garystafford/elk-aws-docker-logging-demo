#!/bin/sh

export MANAGER_NODE=34.206.1.241
ssh -i "~/.ssh/elk-demo" -NL localhost:2375:/var/run/docker.sock docker@${MANAGER_NODE} &
export DOCKER_HOST=tcp://127.0.0.1:2375


export WORKER_NODE_1=ip-172-31-23-24.ec2.internal
export WORKER_NODE_2=ip-172-31-38-25.ec2.internal
export DEPLOY_ENV=Development
export ELK_IP=172.31.23.24

echo "Deploying stack..."
docker stack deploy --compose-file=docker-compose.yml --with-registry-auth elk-demo

echo "waiting for loggers to come up..."
sleep 10s

echo "starting hello services now that loggers are up..."
docker service update --force elk-demo_hello-logspout
docker service update --force elk-demo_hello-gelf
docker service update --force elk-demo_hello-fluentd
