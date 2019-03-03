#!/usr/bin/env bash

### 检查是否已安装
rmp -qa | grep jdk
### 卸载
yum remove xxx

### 下载
cd /chenchunlun/jdk
wget https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u201-linux-x64.rpm
chmod 777 jdk-8u201-linux-x64.rpm

## 默认目录安装 /usr/java (界面)
rpm -ivh jdk-8u201-linux-x64.rpm
cd /usr/java
ls

## 压缩包安装
### 下载后上传
### https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u201-linux-x64.tar.gz
cd /chenchunlun/jdk
tar -xzvf jdk-8u201-linux-x64.tar.gz
pwd
### /chenchunlun/jdk/jdk1.8.0_201/bin

## 环境变量 vim /etc/profile 增加 export
vim /etc/profile
export JAVA_HOME=/chenchunlun/jdk/jdk1.8.0_201
export CLASSPATH=.:$JAVA_HOME/lib
export PATH=$JAVA_HOME/bin:$PATH

## 生效
source /etc/profile

## 检查
java -version