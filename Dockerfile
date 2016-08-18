FROM oraclelinux
MAINTAINER sajani

COPY assets /tmp/assets
COPY build/libs /tmp/assets

RUN yum install -y libaio bc net-tools

RUN rpm -iv http://y-artifactory.dnspam:8080/artifactory/pam-rpm-repo/oracle-xe-11.2.0-1.0.x86_64.rpm

RUN yum install -y http://y-artifactory.dnspam:8080/artifactory/pam-rpm-repo/jdk-8u60-linux-x64.rpm

ENV assets_path /tmp/assets
ENV ORACLE_HOME /u01/app/oracle/product/11.2.0/xe
ENV PATH $ORACLE_HOME/bin:$PATH
ENV JAVA_HOME /usr/java/jdk1.8.0_60

RUN sed -i -E "s/HOST = [^)]+/HOST = 0.0.0.0/g" $ORACLE_HOME/network/admin/listener.ora && \
    sed -i -E "s/HOST = [^)]+/HOST = 0.0.0.0/g" $ORACLE_HOME/network/admin/tnsnames.ora && \
    /etc/init.d/oracle-xe configure responseFile=$assets_path/oracle.rsp && \
    /etc/init.d/oracle-xe enable && \
    echo exit | sqlplus -L SYS/sajani@xe as SYSDBA @$assets_path/create_localgrp.sql && \
    java -Doracle.jdbc.timezoneAsRegion=false -jar $assets_path/oracle-all.jar
