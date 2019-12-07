#!/bin/bash
#Author: chenchanghui@lizi-inc.com
#Date: 2016.06.21
#Desc:
#	    Deploy live video project on online hosts.

#Build home
export BUILD_HOME=/root/live_repush/live
export APP_HOME=$BUILD_HOME/live-root/live-api
export TARGET_HOME=$APP_HOME/target

cd $BUILD_HOME
git fetch
git checkout master
git pull origin master

#Java
export JAVA_HOME=/usr/local/jdk1.8.0_91
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/jre/lib/rt.jar

#Maven
export MAVEN_HOME=/usr/local/apache-maven-3.0.4
export PATH=$PATH:$MAVEN_HOME/bin

cd $BUILD_HOME/live-root
mvn clean install

cd $APP_HOME
mvn clean package -P prod
cd $TARGET_HOME
rm -rf $TARGET_HOME/api.tar.gz
tar czvf $TARGET_HOME/api.tar.gz $TARGET_HOME/live-api/*
scp $TARGET_HOME/api.tar.gz root@host:/usr/local/apache-tomcat-8.0.35/webapps/ROOT/

echo "Done."
echo ""
