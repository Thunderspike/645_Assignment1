FROM tomcat:9.0-jdk15
LABEL "maintainers"="Pol Ajazi; Amurrio Moya"

COPY WebContent /root/WebContent/

RUN cd /root/WebContent && \
  jar -cvf 645_EJBHtmlSurvey.war * && \
  mv 645_EJBHtmlSurvey.war /usr/local/tomcat/webapps/
