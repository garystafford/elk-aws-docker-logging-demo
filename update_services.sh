#!/bin/sh

echo "\nrestarting fluentd and logspout now that ELK are up..."
docker service update --force --detach=false elk-demo_logspout
docker service update --force --detach=false elk-demo_fluentd

echo "\nwaiting for fluentd and logspout to come up..."
sleep 5s

echo "\nrestarting hello services now that fluentd and logspout are up..."
docker service update --force --detach=false elk-demo_hello-logspout
docker service update --force --detach=false elk-demo_hello-gelf
docker service update --force --detach=false elk-demo_hello-fluentd

echo "\nwaiting for hello-world services to come up..."
sleep 5s

echo "\nrestarting nginx now that hello-world services are up..."
docker service update --force --detach=false elk-demo_nginx

echo "\nwaiting for all services to come up..."
sleep 10s
docker service ls
