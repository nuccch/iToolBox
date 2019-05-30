#!/bin/bash
# Author: chench9
# Date: 2019.05.30
# Desc:
#		Format date as string

echo ""
echo "                Raw: `date`"
echo ""

dt=`date +%Y-%m-%d`
echo "         YYYY-MM-DD: $dt"

dt=`date '+%Y-%m-%d %H:%M:%S'`
echo "YYYY-MM-DD HH:MM:SS: $dt"

echo  ""

dt=`date -d '1 hour ago' '+%Y-%m-%d %H:%M:%S'`
echo "       one hour age: $dt"

dt=`date -d '1 day ago' '+%Y-%m-%d'`
echo "        one day ago: $dt"
echo ""
