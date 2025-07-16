FROM openjdk:17-jdk-slim

EXPOSE 8086

COPY target/Foyer-1.4.0-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]
