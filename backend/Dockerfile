
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /workspace
COPY pom.xml .
RUN --mount=type=cache,target=/root/.m2 \
    mvn -B -Dmaven.test.skip=true dependency:go-offline
COPY src ./src
RUN --mount=type=cache,target=/root/.m2 \
    mvn -B -Dmaven.test.skip=true clean package && \
    cp target/app-*.jar target/app.jar

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /workspace/target/app.jar /app/app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
