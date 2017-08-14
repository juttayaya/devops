# Use official openjdk 8 Docker image a parent
# Alpine is a lightweight Uniz that is under 5 MB in size
FROM openjdk:8u131-jdk-alpine

# Who did this?
MAINTAINER Jirawat Uttayaya <jirawat@apps.jirawat.com>

# Spring Boot uses /tmp for Tomcat.
VOLUME /tmp

# Set working directory to /app
WORKDIR /app

# Copy Spring Boot JAR to Docker container
ADD target/helloworld-0.1.0-SNAPSHOT.jar /app/helloworld.jar

# Java environment options to pass to app
ENV JAVA_OPTS=""

# Command to start Spring Boot app
# /dev/urandom reduces startup time
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app/helloworld.jar" ]
