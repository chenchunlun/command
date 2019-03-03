#!/usr/bin/env bash

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

yum install jenkins

#安装路径
sudo rpm -ql jenkins

#启动
nohup java -jar /usr/lib/jenkins/jenkins.war --ajp13Port=-1 --httpPort=8999  > log.file  2>&1 &
#停止
