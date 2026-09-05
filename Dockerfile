# Fully qualified image names are required for Podman CI (no TTY short-name prompt).
FROM docker.io/library/maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app

COPY pom.xml .
RUN mvn -B -q dependency:go-offline

COPY src ./src
RUN mvn -B -q test package

FROM docker.io/library/eclipse-temurin:17-jre-alpine
WORKDIR /app

COPY --from=build /app/target/jenkins-java-demo-1.0.0.jar /app/app.jar

USER 1000

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
