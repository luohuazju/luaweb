#!/usr/bin/env bash

rm -rf ./dist
mkdir -p dist/app/logs
cp -rf conf dist/app
cp -rf html dist/app
cp -rf lua dist/app
cp -rf lualib dist/app

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

compile "./dist/app/lua/web/*"
compile "./dist/app/lua/*"