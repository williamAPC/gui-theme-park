ROM openjdk:12-alpine
ENV DB_URL="jdbc:mysql://db:3306/themepark"
ENV DB_USERNAME="username"
ENV DB_PASSWORD="password"
RUN apk update
RUN apk add curl
ADD build/libs/*.jar theme-park-ride-gradle.jar
ENTRYPOINT exec java -jar theme-park-ride-gradle.jar
HEALTHCHECK --interval=5m --timeout=3s --retries=3 \
    CMD curl -f http://localhost:5000/actuator/health  || exit 1
