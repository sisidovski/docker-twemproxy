FROM ubuntu

MAINTAINER sisidovski <shunya.shishido@gmail.com>

ARG workdir=twemproxy

RUN apt-get update

RUN apt-get -y install libtool make automake git \
 && cd /tmp \
 && git clone https://github.com/twitter/twemproxy.git \
 && cd twemproxy \
 && git checkout v0.4.1 \
 && autoreconf -fvi \
 && ./configure --prefix=/ \
 && make -j2 \
 && make install \
 && cd .. \
 && rm -fr twemproxy \
 && apt-get remove -y libtool make automake git vim redis-server \
 && mkdir $workdir

RUN apt-get -y install vim redis-server

WORKDIR $workdir
ADD /config.yml config.yml

CMD ["nutcracker" "-c" "config.yml"]
