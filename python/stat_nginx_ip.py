#!/usr/bin/python
# encoding=utf8
# Author: chenchanghui@lizi-inc.com
# Date: 2016.03.23
# Desc
#            Stat nginx log ip count
#

import re

nginx_log_path = "/var/log/nginx/access.log"
pattern = re.compile(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}')


#
# 从日志文件中读取ip数据,将ip信息存放在<ip,count>结构中返回
#
def stat_ip_views(log_path):
    ret = {}
    f = open(log_path, "r")
    for line in f:
        match = pattern.match(line)
        if match:
            ip = match.group(0)
            if ip in ret:
                views = ret[ip]
            else:
                views = 0
            views = views + 1
            ret[ip] = views
    return ret


#
# 运行入口函数
#
def run():
    ip_views = stat_ip_views(nginx_log_path)
    max_ip_view = {}
    for ip in ip_views:
        views = ip_views[ip]
        if len(max_ip_view) == 0:
            max_ip_view[ip] = views
        else:
            _ip = max_ip_view.keys()[0]
            _views = max_ip_view[_ip]
            if views > _views:
                max_ip_view[ip] = views
                max_ip_view.pop(_ip)

        print "ip:", ip, ",views:", views

    # 总共有多少ip
    print "total:", len(ip_views)
    # 最大访问的ip
    print "max_ip_view:", max_ip_view


run()
