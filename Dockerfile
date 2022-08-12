FROM openjdk:8-jdk-alpine

LABEL name "Springboot base image" 
LABEL maintainer "Cognizant"
LABEL version=1.0

USER root

ARG JAR_FILE=target/*.jar

COPY ${JAR_FILE} app.jar


ENTRYPOINT ["java","-jar","/app.jar"]
