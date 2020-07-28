#!/bin/bash
# Desc
#		Delete redis keys batch for cluster mode

# Notes:
# 		Must change the params: redis_port, redis_pwd, redis_cmd, redis_hosts before executed


keys_pattern=$1
redis_port=6379
redis_pwd=abc
redis_cmd=redis-cli
redis_host=192.168.56.101

function printUsage() {
	echo "Usage: $0 keys_pattern"
	echo "  e.g: $0 binding*"
	echo ""
}

if [ ! "$keys_pattern" ]; then
	printUsage
	exit 1
fi


# get cluster master node
master_nodes=
if [ ! "$redis_pwd" ]; then
	master_nodes=`$redis_cmd -c -h $redis_host -p $redis_port cluster nodes | grep 'master'`
else
    master_nodes=`$redis_cmd -c -h $redis_host -p $redis_port -a $redis_pwd cluster nodes | grep 'master'`
fi

# echo $master_nodes
for node in ${master_nodes[@]}
do
    if [[ $node =~ '@' ]]
    then
        # echo "master node: $node"
        arr1=(${node//@/ })
        addr=${arr1[0]}
        arr2=(${addr//:/ })
        host=${arr2[0]}
        port=${arr2[1]}
        # echo "$host $port"
        if [ ! "$redis_pwd" ]; then
    		#echo "pwd empty!"
    		$redis_cmd -c -h $host -p $port --scan --pattern $keys_pattern 2>/dev/null | xargs -i $redis_cmd -c -h $host -p $port del {} 2>/dev/null 2>&1
    	else
    		#echo "pwd not empty!"
    		$redis_cmd -c -h $host -p $port -a $redis_pwd --scan --pattern $keys_pattern 2>/dev/null | xargs -i $redis_cmd -c -h $host -p $port -a $redis_pwd del {} 2>/dev/null 2>&1
    	fi
    fi
done

echo "Done."
