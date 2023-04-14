FROM openjdk:19-jdk-alpine3.16
WORKDIR /javaapp 
COPY . .
RUN mvn clean install
ADD /javaapp/target/JacocoExample-0.0.1-SNAPSHOT.jar /javaapp/app.jar
EXPOSE 100
CMD ["java", "-jar", "app.jar"]
