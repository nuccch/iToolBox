#!/usr/bin/python
# encoding=utf8
# Author: chenchanghui@lizi-inc.com
# Date: 2016.03.23
# Desc
#           统计指定URI访问的IP数
#

import re
import time
import datetime
# import MySQLdb
from datetime import date

# nginx_log_path="/root/shell_tools/access.log"
nginx_log_path = "C:/Users/chench/Desktop/access.log"
pattern_ip = re.compile(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}')
pattern_time = re.compile(r'\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}')


#
# Get DB Connection
#
def getDBConnection():
    try:
        print 'Get DB Connection'
        db = MySQLdb.connect(host='123.56.102.224', user='yz_data', passwd='qwe!@#123', db='yz_stat', port=3306,
                             charset='utf8')
        print 'OK.'
        return db
    except MySQLdb.Error, e:
        print 'MySQL ERROR: %d %s' % (e.args[0], e.args[1])
    # return None


#
# 转换为float
#
def parseFloat(str):
    # print 'parse float' 
    f = 0.0
    try:
        f = float(str)
    except:
        f = 0.0
    return f


#
# 在URI中查找eid
#
def findEid(uri):
    idx = uri.find('eid')
    # print uri
    if idx <= 0:
        return 0

    uri = uri[idx:]
    p = re.compile(r'eid=\d+')
    match = p.match(uri)
    if match:
        uri = match.group()
        eid = uri[4:]
        return eid
    else:
        return 0


#
# 从日志文件中读取ip数据,将ip信息存放在<<>>结构中返回
#
def stat_ip_views(log_path):
    data_map = {}  # 存放每个时间点的不同IP统计数
    f = open(log_path, "r")
    for line in f:
        idx = line.find("/api/app")  # 过滤掉不是APP访问请求 
        if idx <= 0:
            # print "not pattern uri"
            continue
        # print line

        arr = line.split()
        time_seconds = arr[len(arr) - 1]
        # print time_seconds

        seconds = parseFloat(time_seconds)
        if seconds <= 0.0:
            continue

        arr = line.split()
        if len(arr) < 7:
            continue

        # print line
        eid = findEid(arr[6])
        time_str = datetime.datetime.fromtimestamp(seconds).strftime('%Y-%m-%d %H:00:00')
        time_str += "|" + eid  # 保存eid
        # print time_str
        # print line

        if time_str in data_map:
            ip_map = data_map[time_str]
        else:
            ip_map = {}

        match = pattern_ip.match(line)  # 提取IP信息
        if match == None:
            continue

        ip = match.group(0)
        if ip in ip_map:
            views = ip_map[ip]
        else:
            views = 0
        views = views + 1
        ip_map[ip] = views
        data_map[time_str] = ip_map
    # print data_map
    return data_map


#
# 将统计信息插入数据库
#
def addHourIP(dt, eid, ip, count):
    print "add ip stat: ", dt, eid, ip, count
    try:
        db = getDBConnection()
        if (db == None):
            return -1
        cur = db.cursor()

        table_name = "exhibition_ip_stat"
        insert_fields = "create_time,stat_time,exhibition_id,ip,count"
        insert_values = "now()" + "," + dt + "," + eid + "," + ip + "," + count
        sql = "insert into " + table_name + "(" + insert_fields + ") values(" + insert_values + ")"

        rows = cur.execute(sql)
        print '%s, Update rows=%s\n' % (sql, rows)
        db.commit()
        cur.close()
        db.close()

        return rows
    except MySQLdb.Error, e:
        print 'MySQL ERROR: %d %s' % (e.args[0], e.args[1])

    return -1


#
# 处理每个时间点的IP统计
#
def hanleHourIP(hour, dayMap):
    # print dayMap
    for (k, v) in dayMap.items():
        arr = hour.split("|")
        if len(arr) < 2:
            continue

        addHourIP(arr[0], arr[1], k, v)

    # DONE


#
# 运行入口函数
#
def run():
    data_map = stat_ip_views(nginx_log_path)
    # print data_map
    for (k, v) in data_map.items():
        hanleHourIP(k, v)

    print "DONE"


if __name__ == "__main__":
    print "main"
    run()

    # print 'Hello,World'

    # t = time.ctime(1458713491);
    # tstr = t.strftime('%Y-%m-%d')
    # print t
    # print tstr

    # data = {}
    # data['2016-03-23 10:00:00']=1
    # data['2016-03-23 11:00:00']=10
    # data['2016-03-23 12:00:00']=1
    # print data

    # map中存放map结构
    # data_time = {}
    # data_ip = {}
    # data_time['2016-03-23 10:00:00'] = data_ip
    # data_ip['192.168.0.1'] = 10
    # data_ip['192.168.0.2'] = 10
    # data_ip['192.168.0.3'] = 30
    # # print data_time
    #  
    # # # 列表
    # data_list = []
    # data_list.append(data_time)
    # data_list.append(data_time)
    # print data_list

    # 格式化日期
    # time_seconds = 1458713491 # 时间秒数
    # time_seconds = 1458720825.651 
    # time_str = datetime.datetime.fromtimestamp(time_seconds).strftime('%Y-%m-%d %H:00:00')
    # print time_str
    # mh = pattern_time.match(time_str)
    # if mh :
    #    print "Match!!"
    #    print mh.group(0)
    # print time_date

    # str = "-"
    # if "-" == str :
    #    print "equals"
