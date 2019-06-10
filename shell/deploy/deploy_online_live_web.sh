#!/bin/bash
#Author: chenchanghui@lizi-inc.com
#Date: 2016.06.21
#Desc:
#	    Deploy live web project on online hosts.

#Build home
export BUILD_HOME=/root/live_repush/liveWeb

cd $BUILD_HOME
git fetch
git checkout linelive
git pull origin linelive

rm -rf $BUILD_HOME/web.tar.gz
tar czvf $BUILD_HOME/web.tar.gz $BUILD_HOME/*
scp $BUILD_HOME/web.tar.gz root@111.223.42.129:/etc/nginx/html/

echo "Done."
echo ""
