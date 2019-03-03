#!/usr/bin/env bash
### 安装ifconfig命令
### 由net-tools包提供
yum provides ifconfig
yum whatprovides ifconfig
yum install net-tools

#######vim :command not found
yum -y install vim*

## wget: command not found
yum -y install wget

######### 强制退出不保存
:q!

########防火墙
systemctl stop firewalld.service #停止firewall
systemctl disable firewalld.service #禁止firewall开机启动

#安装ntpdate工具
yum -y install ntp ntpdate


### 查案系统版本
lsb_release -a

### yum 阿里云镜像 https://opsx.alibaba.com/mirror
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo