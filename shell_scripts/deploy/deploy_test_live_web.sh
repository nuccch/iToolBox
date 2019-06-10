#!/bin/bash
#Author: chenchanghui@lizi-inc.com
#Date: 2016.06.21
#Desc:
#       Deploy live web project on test host.

BUILD_DIR=/root/liveWeb_repush
NGINX_DIR=/etc/nginx

cd $BUILD_DIR/liveWeb

git checkout master
git pull origin master

rm -rf $NGINX_DIR/html/*
cp -R ./* $NGINX_DIR/html/

echo "Done."
echo "Access by: http://192.168.1.40/"
echo ""
