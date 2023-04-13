FROM clojure:openjdk-8-lein

WORKDIR /app

COPY project.clj .
RUN lein deps

COPY . .

RUN lein uberjar
EXPOSE 3000
CMD ["java", "-jar", "target/my-project.jar"]

