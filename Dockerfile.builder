FROM openjdk:17-jdk-slim
RUN echo 1
RUN apt-get update && apt-get install  -y maven
RUN mvn clean && man package

