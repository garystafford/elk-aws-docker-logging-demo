#!/bin/sh

# disconect from AIP Docker dameon
# unset DOCKER_TLS_VERIFY DOCKER_CERT_PATH DOCKER_HOST

export WORKER_NODE_1=ip-172-31-23-24.ec2.internal
export WORKER_NODE_2=ip-172-31-38-25.ec2.internal
export DEPLOY_ENV=Development
export ELK_IP=172.31.23.24
# deploy to aip dev environment
# docker stack remove elk-demo
docker stack deploy --compose-file=docker-compose.yml --with-registry-auth elk-demo
