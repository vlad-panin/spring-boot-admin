FROM kdchubapp01.alfa.bank.int:8082/docker-base-snapshot/alfa-distroless-java8:latest
COPY build/libs/spring-boot-admin.jar /app/spring-boot-admin.jar
ENTRYPOINT ["java", "-jar", "/app/spring-boot-admin.jar"]