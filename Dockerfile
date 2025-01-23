# Stage 1: Build
FROM gradle:8.4-jdk21 as builder

WORKDIR /app

COPY . .

RUN gradle clean build -x test

# Stage 2: Runtime
FROM openjdk:21-slim

WORKDIR /app

COPY --from=builder /app/build/libs/discografia-1.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]