#!/usr/bin/env bash

os_type=""
if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
	os_type="mac"       
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under GNU/Linux platform
	os_type="linux"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Do something under 32 bits Windows NT platform
	os_type="windows_32"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    # Do something under 64 bits Windows NT platform
	os_type="windows_64"
fi
echo "os_type: $os_type"
