FROM maven:3-jdk-8 as builder
WORKDIR /src
COPY . /src
RUN mvn clean package -DskipTests

FROM openjdk:8-jdk-alpine
ENV JAVA_OPTIONS "-Djava.net.preferIPv4Stack=true"
COPY --from=builder /src/target/demo-0.0.1-SNAPSHOT.jar /app/app.jar
WORKDIR /app
CMD ["java", "-jar", "/app/app.jar"]
EXPOSE 8080
