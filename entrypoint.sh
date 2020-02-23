#!/bin/sh

sed -i "s/8888/$PORT/g" /etc/v2ray/config.json
sed -i "s/UUID/$UUID/g" /etc/v2ray/config.json

cat /etc/v2ray/config.json
/usr/bin/v2ray/v2ray -config=/etc/v2ray/config.json
