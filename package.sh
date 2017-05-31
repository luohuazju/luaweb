#!/usr/bin/env bash

rm -rf ./dist
mkdir -p dist/luaweb/logs
cp -rf conf dist/luaweb
cp -rf html dist/luaweb
cp -rf lua dist/luaweb
cp -rf lualib dist/luaweb

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

compile "./dist/luaweb/lua/web/*"
compile "./dist/luaweb/lua/*"
