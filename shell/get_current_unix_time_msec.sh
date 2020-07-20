#!/bin/bash

## ref: https://serverfault.com/questions/151109/how-do-i-get-the-current-unix-time-in-milliseconds-in-bash
#echo "get current unix time as million seconds"

msecs=`date +%s%N | cut -b1-13`
echo "now: $msecs"


