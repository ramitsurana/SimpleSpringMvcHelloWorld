# Docker file based on tomcat 8 image

#FROM tomcat:8
FROM tomcat:8.0.20-jre8
MAINTAINER abirdatta.in@gmail.com

RUN cd ~ && mkdir warfiles

#RUN cd ~ && echo $(ls) && echo $(pwd) && cd warfiles && echo $(pwd)

ADD get-snapshot-artifact.sh /root/warfiles/

#RUN cd ~ && echo $(ls) && echo $(pwd) && cd warfiles && echo $(pwd) && echo $(ls)
#RUN chmod +x ~/warfiles/get-snapshot-artifact.sh

RUN cd ~/warfiles && ./get-snapshot-artifact.sh
#RUN cd ~/warfiles && echo $(ls) 

RUN cp ~/warfiles/*.war /usr/local/tomcat/webapps/

RUN cd ~/warfiles && rm -rf *.war
