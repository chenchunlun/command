#!/usr/bin/env bash
/Users/chenchunlun/develop/apache-maven-3.5.2/bin/mvn deploy:deploy-file -DgroupId=com.sinoxx.3rd_part -DartifactId=tdengine -Dversion=1.0.0 -Dpackaging=jar -Dfile=/Users/chenchunlun/IdeaProjects/Sserver/src/main/resources/JDBCDriver-1.0.0-dist.jar -Durl=https://repo.rdc.aliyun.com/repository/3493-release-klN2YX/ -DrepositoryId=rdc-releases