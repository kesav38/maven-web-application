#took alpine image as base Image
FROM tomcat:jre8-alpine 
# Copy the ".war" file to the Webapps directory of Tomcat image
COPY target/maven-web-application.war /usr/local/tomcat/webapps/maven-web-application.war