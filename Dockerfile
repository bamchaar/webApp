FROM openjdk:17-jdk-slim
MAINTAINER Abdel<bamchaar@gmail.com>
ADD target/uberjar/webapp.jar /webapp/app.jar
RUN echo 1
RUN apt-get update && apt-get install -y curl
RUN curl -o /usr/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
RUN chmod +x /usr/bin/lein

EXPOSE 3000

CMD ["java", "-jar", "/webapp/app.jar"]
