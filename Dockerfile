# Docker file based on tomcat 8 image

FROM tomcat:8.0.20-jre8
MAINTAINER abirdatta.in@gmail.com

RUN cd ~ && mkdir warfiles

ADD target/simplewebapp.war /root/warfiles/

RUN cp ~/warfiles/*.war /usr/local/tomcat/webapps/

RUN cd ~/warfiles && rm -rf *.war
