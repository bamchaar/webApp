FROM openjdk:17-jdk-slim
MAINTAINER Abdel<bamchaar@gmail.com>

ADD target/uberjar/example-webapp.jar /example-webapp/app.jar

EXPOSE 3000

CMD ["java", "-jar", "/example-webapp/app.jar"]
