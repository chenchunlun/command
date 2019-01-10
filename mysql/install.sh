#!/usr/bin/env bash

# 下载mysql源安装包
wget http://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm

# 安装mysql源
yum localinstall mysql57-community-release-el7-8.noarch.rp

# 检查mysql源是否安装成功
yum repolist enabled | grep "mysql.*-community.*"

# 安装MySQL
yum install mysql-community-server

#启动MySQL服务
systemctl start mysqld

#查看MySQL的启动状态
systemctl status mysqld

#开机启动
systemctl enable mysqld
systemctl daemon-reload

#获取root默认密码
grep 'temporary password' /var/log/mysqld.log

#登录数据库
mysql -u root -p 密码

### 修改密码
ALTER USER 'root'@'localhost' IDENTIFIED BY '1234556'
set password for 'root'@'localhost' =password ('123456')

#### 查看密码策略的相关信息
show variables like '%password%';
####### validate_password_policy：密码策略，默认为MEDIUM策略
### 0 or LOW	Length
### 1 or MEDIUM	Length; numeric, lowercase/uppercase, and special characters
### 2 or STRONG	Length; numeric, lowercase/uppercase, and special characters; dictionary file
# 在/etc/my.cnf文件添加validate_password_policy配置，指定密码策略
# 选择0（LOW），1（MEDIUM），2（STRONG）其中一种，选择2需要提供密码字典文件
validate_password_policy=0
validate_password = off

#### 配置默认编码为utf8 /etc/my.cnf
character_set_server=utf8
init_connect='SET NAMES utf8'

##### 添加远程登录用户
GRANT ALL PRIVILEGES ON *.* TO 'username'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;
####修改root允许远程连接
### 找到bind-address = 127.0.0.1这一行 b改为bind-address = 0.0.0.0即可
grant all privileges on *.* to 'root'@'%' identified by '123456' with grant option;
flush privileges;

## 新建用户远程连接mysql数据库
grant all on *.* to admin@'%' identified by '123456' with grant option;
flush privileges;


#### 重新启动mysql服务
systemctl restart mysqld