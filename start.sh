#!/bin/sh -ex

cd /share/luaweb
/tool/openresty/nginx/sbin/nginx -p /share/luaweb -c /share/luaweb/conf/nginx.conf
tail -f /share/luaweb/logs/error.log
