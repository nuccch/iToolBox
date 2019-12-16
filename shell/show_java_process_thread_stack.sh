#!/bin/bash

echo "Show java process thread stack"
pid=$1
if [ ! "$pid" ]; then
	echo "Usage: sh $0 pid"
	echo "  e.g: sh $0 1234"
	echo ""
	exit 1
fi

top -H -p "$pid"|head -20
echo ""

top_thread_id=`top -H -p $pid|head -8|awk '/java/{print $2}'`
#echo "topest cpu thread: $top_thread_id"

thread_id_hex=`printf "%x" "$top_thread_id"`
#echo "$thread_id_hex"
jstack "$pid"|grep "$thread_id_hex" -A 30 > jstack_tmp
cat jstack_tmp
rm -rf jstack_tmp

#echo "Done."
