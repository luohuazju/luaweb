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
RUN apt-get install -y libssl-dev wget unzip

#install 
RUN     mkdir -p /tool
RUN     mkdir -p /install

#install openresty
ADD	install/openresty-1.11.2.3.tar.gz /install/
WORKDIR /install/openresty-1.11.2.3
RUN	./configure --prefix=/tool/openresty
RUN     make 
RUN     make install

#install luarocks
ADD	install/luarocks-2.4.2.tar.gz /install/
WORKDIR /install/luarocks-2.4.2
RUN	./configure --prefix=/tool/luarocks --with-lua="/tool/openresty/luajit" --lua-suffix="jit" --with-lua-include="/tool/openresty/luajit/include/luajit-2.1"
RUN	make build
RUN	make install

#install dependencies
RUN	/tool/luarocks/bin/luarocks install md5

#install app
RUN	mkdir -p /share/
ADD	dist/raspberrypi-openresty-1.0.tgz /share/	

#start the application
EXPOSE  80
RUN     mkdir -p /app/ 
ADD     start.sh /app/ 
WORKDIR /app/
CMD	[ "./start.sh" ]
