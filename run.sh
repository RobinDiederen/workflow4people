#!/bin/sh
export GRAILS_OPTS="-Xmx900m -XX:MaxPermSize=512m"
export JAVA_OPTS="-Xmx700m -XX:MaxPermSize=384m"
grails -Dserver.port=8082 run-app
