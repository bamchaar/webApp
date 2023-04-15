FROM clojure:openjdk-8-lein

WORKDIR /usr/src/app


COPY project.clj /usr/src/app
RUN lein deps

COPY . /usr/src/app

RUN lein uberjar
EXPOSE 3080
CMD ["java", "-jar", "target/my-project.jar"]

