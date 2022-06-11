FROM openjdk:8
COPY build/libs/spring-boot-admin.jar /app/spring-boot-admin.jar
ENTRYPOINT ["java", "-jar", "/app/spring-boot-admin.jar"]