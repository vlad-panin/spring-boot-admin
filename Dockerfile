FROM gradle:7.4.2-jdk8 as builder
COPY . /app
WORKDIR /app
RUN gradle bootJar

FROM openjdk:8
COPY --from=builder build/libs/spring-boot-admin.jar /app/spring-boot-admin.jar
ENTRYPOINT ["java", "-jar", "/app/spring-boot-admin.jar"]