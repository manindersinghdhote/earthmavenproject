# Use the official Tomcat image as the base image
FROM tomcat:9.0-jdk11-openjdk-slim

# Set the working directory inside the container
WORKDIR /usr/local/tomcat/webapps

# Copy the generated .war file into the webapps directory of Tomcat
COPY target/earth-app-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/earth-app.war

# Expose port 8080 to access the application
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
