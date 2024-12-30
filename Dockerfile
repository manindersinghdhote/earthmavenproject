# Stage 1: Build the Maven project
FROM maven:3.8.6-eclipse-temurin-17 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code into the container
COPY pom.xml ./
COPY src ./src

# Run Maven to package the project
RUN mvn clean package

# Stage 2: Serve the built files
FROM nginx:alpine

# Set the working directory inside the container
WORKDIR /usr/share/nginx/html

# Copy the built WAR file (or static files) from the builder stage
COPY --from=builder /app/target/*.war .

# Expose port 80 for the web server
EXPOSE 80

# Start the NGINX server
CMD ["nginx", "-g", "daemon off;"]
