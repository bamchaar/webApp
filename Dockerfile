FROM openjdk:17-jdk-slim
MAINTAINER Abdel<bamchaar@gmail.com>
RUN echo 1
RUN apt-get update && apt-get install -y curl
RUN curl -o /usr/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
RUN chmod +x /usr/bin/lein
CMD ["java", "-jar", "/webapp/app.jar"]
# RUN lein  uberjar
ADD target/uberjar/webapp.jar /webapp/app.jar

EXPOSE 3000


