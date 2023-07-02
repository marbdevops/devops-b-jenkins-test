FROM adoptopenjdk/openjdk11:x86_64-alpine-jre-11.0.18_10
VOLUME /tmp
COPY target/demo*.jar app.jar
CMD java -jar app.jar
RUN ls -lrt
RUN echo hello
