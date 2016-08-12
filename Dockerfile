FROM oraclelinux
MAINTAINER sajani

COPY oracle.rsp /tmp/oracle.rsp

RUN yum install -y libaio bc net-tools

RUN rpm -iv http://y-artifactory.dnspam:8080/artifactory/pam-rpm-repo/oracle-xe-11.2.0-1.0.x86_64.rpm

RUN /etc/init.d/oracle-xe configure responseFile=/tmp/oracle.rsp

RUN /etc/init.d/oracle-xe enable
