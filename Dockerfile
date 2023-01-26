FROM devopsedu/webapp:latest

COPY website /var/www/html/

RUN apt-get update

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && apt-get install -y -q dialog apt-utils

RUN apt install -y php


CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
