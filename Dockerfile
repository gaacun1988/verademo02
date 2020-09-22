FROM centos:7.8.2003

LABEL maintainer="ylerer@veracode.com"

RUN mkdir /opt/tomcat/

WORKDIR /opt/tomcat
RUN curl -O https://apache.mirror.digitalpacific.com.au/tomcat/tomcat-9/v9.0.38/bin/apache-tomcat-9.0.38.tar.gz
RUN tar xzvf apache-tomcat-9.0.38.tar.gz
RUN mv apache-tomcat-*/* /opt/tomcat/.
RUN yum -y install java
RUN java -version

WORKDIR /opt/tomcat/webapps
ADD /target/verademo.war verademo.war

# install Python for scanning
RUN yum install -y \
    https://repo.ius.io/ius-release-el7.rpm \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum -y install --enablerepo=ius python36u python36u-libs python36u-devel python36u-pip
RUN python3.6 -V

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]

# docker build --tag [Name Of the Image][:version (optional)]  .
# docker container run -it -d --name verademo -p 80:8080 <image name from above>
