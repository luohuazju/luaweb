#Set up nginx in Docker

#Prepre the OS
FROM resin/rpi-raspbian:jessie
MAINTAINER Carl Luo <luohuazju@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update
RUN apt-get install -y apt-utils
RUN apt-get -y dist-upgrade
RUN apt-get install -y build-essential gcc make
RUN apt-get install -y libpcre3 libpcre3-dev zlib1g-dev libgcrypt11-dev

#install nginx
RUN     mkdir -p /tool
RUN     mkdir -p /install
ADD	install/nginx-1.11.6.tar.gz /install/
WORKDIR /install/nginx-1.11.6
RUN	./configure --prefix=/tool/nginx-1.11.6
RUN     make 
RUN     make install

#config nginx
ADD     conf/nginx.conf /tool/nginx-1.11.6/conf/

#start the application
EXPOSE  80
RUN     mkdir -p /app/ 
ADD     start.sh /app/ 
WORKDIR /app/
CMD	[ "./start.sh" ]
