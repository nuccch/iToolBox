#!/bin/bash
#Author: chenchanghui@lizi-inc.com
#Date: 2016.06.21
#Desc:
#       Deploy live api project on test host.

#Build home
export BUILD_HOME=/root/live_repush/live

cd $BUILD_HOME
git fetch
git checkout master
git pull origin master

#Java
export JAVA_HOME=/usr/local/jdk1.8.0_91/
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/jre/lib/rt.jar

#Maven
export MAVEN_HOME=/usr/local/apache-maven-3.3.9
export PATH=$PATH:$MAVEN_HOME/bin

#Tomcat
export TOMCAT_HOME=/usr/local/apache-tomcat-8.0.35

echo ""
echo "Stop tomcat ..."
sh $TOMCAT_HOME/bin/shutdown.sh
sleep 3
echo "Stop done."
echo ""

rm -rf $TOMCAT_HOME/webapps/ROOT/*

cd $BUILD_HOME/live-root
mvn clean install

cd $BUILD_HOME/live-root/live-api
mvn clean package -P dev
mv $BUILD_HOME/live-root/live-api/target/live-api/* $TOMCAT_HOME/webapps/ROOT/

#init java env
#ENV_NAME=jar.env
#printf $TOMCAT_HOME/webapps/ROOT/WEB-INF/classes >> /root/$ENV_NAME
#printf ':' >> /root/$ENV_NAME
#libs=`ls $TOMCAT_HOME/webapps/ROOT/WEB-INF/lib`
#for j in $libs; do
#   printf $TOMCAT_HOME/webapps/ROOT/WEB-INF/lib/$j >> /root/$ENV_NAME
#   printf ':' >> /root/$ENV_NAME
#done

echo ""
echo "Start tomcat ..."
sh $TOMCAT_HOME/bin/startup.sh

echo "Done."
echo "Access by:"
echo "http://192.168.1.40:8200/"
echo ""
