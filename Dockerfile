# 階段 1：Maven Build
# 將原本的 17-alpine 改為 25-alpine，提供 JDK 25 編譯環境
FROM maven:3.9-eclipse-temurin-25-alpine AS build
WORKDIR /app
COPY pom.xml .
# 這裡會下載相關的依賴
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

# 階段 2：執行環境
# 將原本的 17-jre-alpine 改為 25-jre-alpine，提供 Java 25 執行環境
FROM eclipse-temurin:25-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENV PORT=8080
EXPOSE ${PORT}
ENTRYPOINT ["java", "-jar", "app.jar"]