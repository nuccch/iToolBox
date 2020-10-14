#!/bin/bash

# trim all space
str="Hello,    World!"
str_trim_all_space="${str//[[:space:]]/}"
echo "-------------trim all spaces------------------"
echo "               str: $str"
echo "str trim all space: $str_trim_all_space"

echo ""

# trim only space characters before and after string
str="     Hello,      World!    "
str_trim_only_before_after=`echo "${str}" | sed -e 's/^[[:space:]]*//'`
echo "------------trim only before and after spaces--------------"
echo "                       str: $str"
echo "str trim only before_after: $str_trim_only_before_after"

