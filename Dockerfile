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
ENV RABBITMQ_CONFIG_FILE $RABBITMQ_BASE/conf/rabbitmq

# persistent
ENV RABBITMQ_MNESIA_BASE $RABBITMQ_BASE/mnesia

#log 
ENV RABBITMQ_LOG_BASE $RABBITMQ_BASE/log

#enabled plugins log
ENV RABBITMQ_ENABLED_PLUGINS_FILE $RABBITMQ_BASE/enabled_plugins

COPY conf $RABBITMQ_BASE/conf

RUN mkdir -p $RABBITMQ_BASE \
	&& cat /etc/passwd \
	&& chown -R rabbitmq $RABBITMQ_BASE


EXPOSE 15672 5672 5671 4369

CMD 	rabbitmq-plugins enable rabbitmq_management ; \
	rabbitmq-server -detached ; \
	/bin/bash ;
