#!/bin/sh

# Restart (update) ELK Demo Docker services in the correct order
# Maintainer: Gary A. Stafford <garystafford@rochester.rr.com>

echo "\n Restarting fluentd and logspout now that ELK are up..."
docker service update --force --detach=false elk-demo_logspout
docker service update --force --detach=false elk-demo_fluentd

echo "\n Waiting for fluentd and logspout to come up..."
sleep 5s

echo "\n Restarting hello services now that fluentd and logspout are up..."
docker service update --force --detach=false elk-demo_hello-logspout
docker service update --force --detach=false elk-demo_hello-gelf
docker service update --force --detach=false elk-demo_hello-fluentd

echo "\n Waiting for hello-world services to come up..."
sleep 5s

echo "\n Restarting nginx now that hello-world services are up..."
docker service update --force --detach=false elk-demo_nginx

echo "\n Waiting for all services to fully start..."
sleep 10s
docker service ls
