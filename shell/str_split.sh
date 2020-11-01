#!/bin/bash
 
str="Learn-to-Split-a-String-in-Bash-Scripting"
 
IFS='-' # hyphen (-) is set as delimiter
read -ra ADDR <<< "$str" # str is read into an array as tokens separated by IFS
echo ${ADDR[1]}
for i in "${ADDR[@]}"; do # access each element of array
    echo "$i"
done
IFS=' ' # reset to default value after usage
