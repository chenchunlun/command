#!/usr/bin/env bash

# top查看进程占用资源情况
top

# 查找线程
# 使用top -H -p <pid>查看线程占用情况
ps p 88994 -L -o pcpu,pmem,pid,tid,time,tname,cmd

# 查找java的堆栈信息
jstack -l 88994 > /sinoxx/jstack/88994.log
/sinoxx/jdk1.8.0_201/bin/jstack -l 88994 >> /sinoxx/jstack/88994.txt

# 将线程id转换成十六进制
printf "%x\n" 89065


# jstack查询线程的堆栈信息
# 语法：jstack <pid> | grep -a 线程id（十六进制）
# jstack <pid> | grep -a 3d30
/sinoxx/jdk1.8.0_201/bin/jstack 88994 | grep -a 15c29