# Docker Logging on AWS Demo

Repo for article that will explore self-hosted log aggregation and visualization of a Dockerized application on AWS, using the ELK Stack. The post details three common variations of log collection and routing to ELK, using various Docker logging drivers, along with Logspout, Fluentd, and GELF (Graylog Extended Log Format).

## Deployment

All Docker service containers are deployed to the AWS-based Docker Swarm using a single Docker Compose file. The order of service startup is critical. ELK should fully startup first, followed by Fluentd and Logspout, then the three sets of Hello-World instances, and finally NGINX.

To deploy and start all the Docker services correctly, there are two scripts in the GitHub repository. First, execute the following command, `sh ./stack_deploy.sh`. This will deploy the Docker service stack and create an overlay network, containing all the services as configured in the `docker-compose.yml` file. Then, to ensure the services start in the correct sequence, execute `sh ./service_update.sh`. This will restart each service in the correct order, with pauses between services to allow time for startup; a bit of a hack, but effective.

## Docker Swarm on AWS
```text
$ docker node ls

ID                            HOSTNAME                        STATUS              AVAILABILITY        MANAGER STATUS
tc2mwa29jl21bp4x3buwbhlhx     ip-172-31-5-65.ec2.internal     Ready               Active
ueonffqdgocfo6dwb7eckjedz     ip-172-31-29-135.ec2.internal   Ready               Active
n9zportqziqyzqsav3cbfakng     ip-172-31-39-165.ec2.internal   Ready               Active
ao55bv77cs0542x9arm6droyo *   ip-172-31-47-42.ec2.internal    Ready               Active              Leader
```

## Deployed Docker Service Stack
```text
$ docker service ls

ID                  NAME                       MODE                REPLICAS            IMAGE                                 PORTS
6va602lzfl4y        dockercloud-server-proxy   global              1/1                 dockercloud/server-proxy              *:2376->2376/tcp
jjjddhuczx35        elk-demo_elk               replicated          1/1                 garystafford/custom-elk:latest        *:5000->5000/udp,*:5044->5044/tcp,*:5601->5601/tcp,*:9200->9200/tcp,*:12201->12201/udp
mwm1rbo3dp3t        elk-demo_fluentd           global              2/2                 garystafford/custom-fluentd:latest    *:24224->24224/tcp,*:24224->24224/udp
ofo02g2kbhg7        elk-demo_hello-fluentd     replicated          2/2                 garystafford/hello-world:latest
05txkpmizwxq        elk-demo_hello-gelf        replicated          2/2                 garystafford/hello-world:latest
pjs614raq37y        elk-demo_hello-logspout    replicated          2/2                 garystafford/hello-world:latest
9h0l0w2ej1yw        elk-demo_logspout          global              2/2                 garystafford/custom-logspout:latest
wpxjji5wwd4j        elk-demo_nginx             replicated          2/2                 garystafford/custom-nginx:latest      *:80->80/tcp
w0y5inpryaql        elk-demo_portainer         global              1/1                 portainer/portainer:latest            *:9000->9000/tcp
```
