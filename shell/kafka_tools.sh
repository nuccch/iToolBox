#!/bin/bash
# Desc:
#	check kafka consumer group data tag

kafka_home=/opt/iotplatform/kafka_2.11-2.3.0
kafka_broker="localhost:9092"
consumer_group=datahub-prod
action=$1

printHelp()
{
	echo ""
	echo "               e.g group: $consumer_group"
	echo "show consumer group list: $kafka_home/bin/kafka-consumer-groups.sh --bootstrap-server $kafka_broker --list|grep $consumer_group"
	echo "show consumer group tags: $kafka_home/bin/kafka-consumer-groups.sh --bootstrap-server $kafka_broker --group $consumer_group --describe"
	echo ""
}

printUsage() 
{
	echo "  Usage: $0 action"
	echo "    e.g: $0 help"
	
	echo "Actions:"
	echo "	show-group-list"
	echo "	show-group-tag"
	echo "	help"
	echo ""
}

showGroupList() 
{
	consumer_groups=`$kafka_home/bin/kafka-consumer-groups.sh --bootstrap-server $kafka_broker --list|grep $consumer_group`	
	echo "------------------------------------------ GROUP LIST ------------------------------------------"
	i=0
	for group in ${consumer_groups[@]}
	do
		let i+=1
		printf "group: %-70s number: %-5d" $group $i
		echo ""
	done
}

showGroupTag()
{
	consumer_groups=`$kafka_home/bin/kafka-consumer-groups.sh --bootstrap-server $kafka_broker --list|grep $consumer_group`
	echo "------------------------------------------ GROUP TAGS ------------------------------------------"
	i=0
	for group in ${consumer_groups[@]}
	do
		let i+=1
		#echo "group: $group number: $i"
		printf "group: %-70s number: %-5d" $group $i
	
		$kafka_home/bin/kafka-consumer-groups.sh  --describe --group $group --bootstrap-server $kafka_broker
		echo ""
	done
	echo ""
}


if [ ! "$action" ]; then
	printUsage
	exit 1
fi

if [ "show-group-list" != "$action" ] && [ "show-group-tag" != "$action" ] && [ "help" != "$action" ]; then
	echo "Unknow action" 
	printUsage
	exit 1
fi

if [ "help" == "$action" ]; then
	printHelp
elif [ "show-group-list" == "$action" ]; then
	showGroupList
elif [ "show-group-tag" == "$action" ]; then
	showGroupList
	showGroupTag
fi


