#!/bin/bash

wget http://192.168.122.1:8081/repository/maven-snapshots/com/demo/simplewebapp/maven-metadata.xml -O baseVersion.xml

TEMP_VERSION=`grep \<version\> ./baseVersion.xml `
echo ">>>>>$TEMP_VERSION<<<<<"

BASE_VERSION=$(echo "${TEMP_VERSION}" | sed -e 's/<version>\(.*\)<\/version>/\1/' | sed -e 's/ //g')
echo ">>>$BASE_VERSION<<<"

wget 'http://192.168.122.1:8081/repository/maven-snapshots/com/demo/simplewebapp/'${BASE_VERSION}'/maven-metadata.xml' -O artifactVersion.xml

TEMP_VERSION=`grep -m 1 \<value\> ./artifactVersion.xml`
echo ">>>>>$TEMP_VERSION<<<<"

FINAL_VERSION=$(echo "${TEMP_VERSION}" | sed -e 's/<value>\(.*\)<\/value>/\1/' | sed -e 's/ //g')
echo ">>>>>$FINAL_VERSION<<<<"

wget 'http://192.168.122.1:8081/repository/maven-snapshots/com/demo/simplewebapp/'${BASE_VERSION}'/simplewebapp-'${FINAL_VERSION}'.war' -O  simplewebapp.war
