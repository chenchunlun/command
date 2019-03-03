#!/usr/bin/env bash
cd chenchunlun/tomcat
wget https://www-eu.apache.org/dist/tomcat/tomcat-9/v9.0.16/bin/apache-tomcat-9.0.16.tar.gz
tar -xzvf apache-tomcat-9.0.16.tar.gz

## 配置UTF_8 server.xml 8080配置 URIEncoding=UTF-8
