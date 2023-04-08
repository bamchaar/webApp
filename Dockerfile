FROM openjdk:17-jdk-slim
MAINTAINER Abdel<bamchaar@gmail.com>

ADD target/uberjar/webapp.jar /webapp/app.jar

EXPOSE 3000

CMD ["java", "-jar", "/webapp/app.jar"]
