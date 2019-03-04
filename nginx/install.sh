#!/usr/bin/env bash
### 安装gcc
yum install gcc
## 安装pcre-devel
yum install pcre-devel
### 安装 zlib
yum install zlib zlib-devel
### 安装open ssl
yum install openssl openssl-devel

### 下载nginx
cd /chenchunlun/nginx
wget http://nginx.org/download/nginx-1.15.9.tar.gz
tar -xzvf nginx-1.15.9.tar.gz
cd /chenchunlun/nginx/nginx-1.15.9
sudo ./configure
whereis nginx
make
make install

###
cd /usr/local/nginx

### 测试配置文件是否正确
/usr/local/nginx/sbin
./nginx -t
## 启动
./nginx

### 停止
./nginx -s stop
./nginx -s quit

## 重启
./nginx -s reload

ps -ef | grep nginx

### 平滑重启
kill -HUP ${pid}