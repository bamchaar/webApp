FROM clojure:openjdk-8-lein

WORKDIR .

COPY project.clj .
RUN lein deps

COPY . .

RUN lein uberjar
EXPOSE 3080
CMD ["java", "-jar", "target/my-project.jar"]

