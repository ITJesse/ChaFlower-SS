#!/bin/bash

SERVER_IP=${SERVER_IP:-0.0.0.0}
SERVER_PASSWORD=${SERVER_PASSWORD}
SERVER_METHOD=${SERVER_METHOD}

sed 's/{{server}}/'"${SERVER_IP}"'/' -i /etc/shadowsocks-libev/config.json
sed 's/{{password}}/'"${SERVER_PASSWORD}"'/' -i /etc/shadowsocks-libev/config.json
sed 's/{{method}}/'"${SERVER_METHOD}"'/' -i /etc/shadowsocks-libev/config.json

exec /usr/bin/supervisord
