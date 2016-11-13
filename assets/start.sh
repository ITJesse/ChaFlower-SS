#!/bin/bash

SERVER_IP=${SERVER_IP:-0.0.0.0}
SERVER_PASSWORD=${SERVER_PASSWORD}
SERVER_METHOD=${SERVER_METHOD}
LOCAL_IP=${LOCAL_IP:-0.0.0.0}
TIMEOUT=${TIMEOUT:-600}

sed 's/{{server}}/'"${SERVER_IP}"'/' -i /etc/shadowsocks-libev/config.json
sed 's/{{local}}/'"${LOCAL_IP}"'/' -i /etc/shadowsocks-libev/config.json
sed 's/{{password}}/'"${SERVER_PASSWORD}"'/' -i /etc/shadowsocks-libev/config.json
sed 's/{{method}}/'"${SERVER_METHOD}"'/' -i /etc/shadowsocks-libev/config.json
sed 's/{{timeout}}/'"${TIMEOUT}"'/' -i /etc/shadowsocks-libev/config.json

exec /usr/bin/supervisord
