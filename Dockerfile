FROM centos

MAINTAINER mypjb/rabbitmq maintainer 280417314@qq.com

Run yum install -y wget net-tools nano

RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm \
	&& yum install -y erlang

RUN curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh \
	| bash \
	&& yum install -y rabbitmq-server-3.6.9-1.el7.noarch

ENV RABBITMQ_BASE /usr/local/rabbitmq

ENV RABBITMQ_CONFIG_FILE $RABBITMQ_BASE/conf

ENV RABBITMQ_MNESIA_BASE $RABBITMQ_BASE/mnesia

ENV RABBITMQ_LOG_BASE $RABBITMQ_BASE/log

Run mkdir -p $RABBITMQ_CONFIG_FILE $RABBITMQ_MNESIA_BASE $RABBITMQ_LOG_BASE \
	&& chmod -R 777 $RABBITMQ_BASE

EXPOSE 15672 5672 5671 4369

CMD rabbitmq-plugins enable rabbitmq_management ; rabbitmq-server ; /bin/bash ;
