# Stage 1: Build the Maven project
FROM maven:3.8.6-eclipse-temurin-17 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code into the container
COPY pom.xml ./
COPY ./src/main/webapp /app/src/main/webapp

# Run Maven to package the project
RUN mvn clean package

# Stage 2: Serve the static files using NGINX
FROM nginx:alpine

# Set the working directory inside the container
WORKDIR /usr/share/nginx/html

# Copy the built static files (HTML, CSS, etc.) from the builder stage
COPY --from=builder /app/target/*.war /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80

# Start the NGINX server
CMD ["nginx", "-g", "daemon off;"]
