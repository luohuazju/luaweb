#!/usr/bin/env bash

rm -rf ./luaweb-1.0
mkdir -p luaweb-1.0/logs
cp -rf conf luaweb-1.0
cp -rf html luaweb-1.0
cp -rf lua luaweb-1.0
cp -rf lualib luaweb-1.0

luajit=/opt/openresty/luajit/bin/luajit

function compile() {
    for file in $1
    do
        if test -f $file
        then
            $luajit -b $file $file
        fi
    done
}

compile "./luaweb-1.0/lua/web/*"
compile "./luaweb-1.0/lua/*"
