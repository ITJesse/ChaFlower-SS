FROM ubuntu:14.04
MAINTAINER jesse@itjesse.cn

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /usr/local/src/

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
ADD ./assets/sources.list.trusty /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y build-essential autoconf libtool libssl-dev \
    gawk debhelper dh-systemd init-system-helpers pkg-config git

RUN git clone https://github.com/shadowsocks/shadowsocks-libev.git \
	&& cd shadowsocks-libev \
	&& dpkg-buildpackage -b -us -uc -i \
	&& cd .. \
	&& dpkg -i shadowsocks-libev*.deb

RUN mkdir -p /var/log/supervisor
COPY /assets/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY /assets/config.json /etc/shadowsocks-libev/config.json
ADD start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 995

CMD ["/start.sh"]

