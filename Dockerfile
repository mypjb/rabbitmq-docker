FROM centos

MAINTAINER mypjb/rabbitmq maintainer 280417314@qq.com

Run yum install -y wget net-tools nano

RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm \
	&& yum install -y erlang

RUN curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh \
	| bash \
	&& yum install -y rabbitmq-server-3.6.9-1.el7.noarch

# root dir
ENV RABBITMQ_BASE /usr/local/rabbitmq

#conf dir
ENV RABBITMQ_CONFIG_FILE $RABBITMQ_BASE/conf

# persistent
ENV RABBITMQ_MNESIA_BASE $RABBITMQ_BASE/mnesia

#log 
ENV RABBITMQ_LOG_BASE $RABBITMQ_BASE/log

#enabled plugins log
ENV RABBITMQ_ENABLED_PLUGINS_FILE $RABBITMQ_BASE/enabled_plugins

ENV RABBITMQ_URL https://github.com/mypjb/rabbitmq-docker.git

RUN mkdir -p $RABBITMQ_BASE \
	&& chmod -R 777 $RABBITMQ_BASE

RUN yum install -y git \
	&& git clone $RABBITMQ_URL git \
	&& cp git/conf $RABBITMQ_BASE \
	&& rm -rf git

EXPOSE 15672 5672 5671 4369

CMD 	rabbitmq-plugins enable rabbitmq_management ; \
	rabbitmq-server ; /bin/bash ;
