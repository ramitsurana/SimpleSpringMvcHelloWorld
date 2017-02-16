# Docker file based on tomcat 8 image

#FROM tomcat:8
FROM tomcat:8.0.20-jre8
MAINTAINER abirdatta.in@gmail.com

RUN cd ~ && mkdir warfiles && cd ~/warfiles && wget --no-check-certificate https://github.com/abirdatta/SimpleSpringMvcHelloWorld/raw/master/target/simplewebapp.war 

RUN cp ~/warfiles/*.war /usr/local/tomcat/webapps/

RUN cd ~/warfiles && rm -rf *.war
