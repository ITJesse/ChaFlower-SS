FROM ubuntu:14.04
MAINTAINER jesse@itjesse.cn

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /usr/local/src/

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
ADD ./assets/sources.list.trusty /etc/apt/sources.list

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y build-essential autoconf libtool libssl-dev \
    gawk debhelper dh-systemd init-system-helpers pkg-config git apg supervisor

RUN git clone https://github.com/shadowsocks/shadowsocks-libev.git \
	&& cd shadowsocks-libev \
	&& dpkg-buildpackage -b -us -uc -i \
	&& cd .. \
	&& dpkg -i shadowsocks-libev*.deb

RUN apt-get purge -y build-essential autoconf libtool \
	gawk debhelper dh-systemd pkg-config git \
	&& rm -rf /usr/local/src/*

RUN apt-get autoremove --purge -y \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /var/log/supervisor
COPY /assets/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY /assets/config.json /etc/shadowsocks-libev/config.json
ADD /assets/start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 995

CMD ["/start.sh"]
