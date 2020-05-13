#!/bin/bash
# fix wechat black frame on ubuntu 18.04 LTS

# pre install: sudo apt-get install wmctrl xdotool

wd=`wmctrl -l -G -p -x|grep ChatContactMenu|awk '{print $1}'`
xdotool windowunmap $wd
