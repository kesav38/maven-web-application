FROM tomcat:8.0.20-jre8
COPY maven-web-application-1/target/maven-web-application*.war /usr/local/tomcat/webapps/maven-web-application.war
