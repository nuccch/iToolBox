#!/bin/bash
# Author: chench9
# Date: 2019.05.30
# Desc:
#		Get just file name without suffix in path

file_name=`ls ./*.sh | xargs -n 1 basename`
file_name="${file_name%.*}"
echo $file_name
