# rabbitmq-docker
this is a rabbitmq docker project
start:
docker run -dit -v rabbitmq:/usr/local/rabbitmq --name rabbitmq -p 4369:4369 -p 5672:5672 -p 5671:5671 -p 15672:15672 mypjb/rabbitmq
