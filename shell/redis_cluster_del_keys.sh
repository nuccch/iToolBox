#!/bin/bash
# Desc
#		Delete redis keys batch for cluster mode

# Notes:
# 		Must change the params: redis_port, redis_pwd, redis_cmd, redis_hosts before executed


keys=$1
redis_port=6379
redis_pwd=
redis_cmd=/usr/local/redis/bin/redis-cli
redis_hosts=(redis1.iot.com redis2.iot.com redis3.iot.com redis4.iot.com redis5.iot.com redis6.iot.com)

function printUsage() {
	echo "Usage: $0 keys_pattern"
	echo "  e.g: $0 binding*"
	echo ""
}

if [ ! "$keys" ]; then
	printUsage
	exit 1
fi

for host in ${redis_hosts[@]}
do
	if [ ! "$redis_pwd" ]; then
		#echo "pwd empty!"
		$redis_cmd -c -h $host -p $redis_port --scan --pattern $keys | xargs -i $redis_cmd -c -h $host -p $redis_port del {}
	else
		#echo "pwd not empty!"
		$redis_cmd -c -h $host -p $redis_port -a $redis_pwd --scan --pattern $keys | xargs -i $redis_cmd -c -h $host -p $redis_port -a $redis_pwd del {}
	fi
done

echo "Done."
