#!/bin/bash

echo "Show nginx versions..."
web=`curl -s https://nginx.org/en/download.html`
#echo "$web"

echo "$web"|grep -o "nginx-[0-9]\+.[0-9]\+.[0-9]\+.tar.gz\"" > nginx.version
#echo "$web"|grep -e 'nginx' > nginx.version
cat /Users/chench/nginx.version | grep -o "nginx-[0-9]\+.[0-9]\+.[0-9]\+"
rm -rf nginx.version
