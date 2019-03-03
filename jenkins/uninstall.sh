#!/usr/bin/env bash

service jenkins stop
yum clean all
yum -y remove jenkins
rm -rf /var/cache/jenkins
rm -rf /var/lib/jenkins/