#!/bin/sh
#Date: 2017.10.13
#Author: chench9@lenovo.com
#Version: 1.0.0
#Desc: 
#	create self-signed ROOT CA for development or test

printUsage() {
	echo "Usage: "
	echo "sh $0"
	echo ""
}

echo "Create self-signed ROOT CA"
read -p "Enter your domain [www.example.com]: " DOMAIN

# Step1: Create CA private key file: $DOMAIN.key
openssl genrsa -des3 -out $DOMAIN.key 1024

# Step2: Create CA signing request file: $DOMAIN.csr
#SUBJECT="/C=mycountry/ST=myprovince/L=mycity/O=myorganization/OU=mygroup/CN=$DOMAIN"
SUBJECT="/C=US/ST=Beijing/L=Beijing/O=myorganization/OU=mygroup/CN=$DOMAIN"
openssl req -new -subj $SUBJECT -key $DOMAIN.key -out $DOMAIN.csr

# Step3: Decrypt CA private key file
mv $DOMAIN.key $DOMAIN.origin.key
openssl rsa -in $DOMAIN.origin.key -out $DOMAIN.key

# Step4: Sign SSL certificate file: $DOMAIN.crt
openssl x509 -req -days 3650 -in $DOMAIN.csr -signkey $DOMAIN.key -out $DOMAIN.crt

echo  ""
echo "TODO:"
echo "Copy $DOMAIN.crt to /etc/nginx/ssl/$DOMAIN.crt"
echo "Copy $DOMAIN.key to /etc/nginx/ssl/$DOMAIN.key"
echo "Add configuration in nginx:"
echo "server {"
echo "    ..."
echo "    listen 443 ssl;"
echo "    ssl_certificate     /etc/nginx/ssl/$DOMAIN.crt;"
echo "    ssl_certificate_key /etc/nginx/ssl/$DOMAIN.key;"
echo "}"

