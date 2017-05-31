#!/bin/sh -ex

cd /share/luaweb-1.0
/tool/openresty/nginx/sbin/nginx -p /share/luaweb-1.0 -c /share/luaweb-1.0/conf/nginx.conf
