FROM maven:3.6.3-jdk-8 as build

WORKDIR /routing-engine

COPY routing-engine .

RUN mvn clean install

FROM openjdk:11.0-jre

ENV JAVA_OPTS "-Xmx1g -Xms1g"

RUN mkdir -p /data

WORKDIR /routing-engine

COPY --from=build /routing-engine/web/target/graphhopper*.jar ./

COPY graphhopper.sh routing-engine/config-example.yml ./

# Enable connections from outside of the container
RUN sed -i '/^ *bind_host/s/^ */&# /p' config-example.yml

VOLUME [ "/data" ]

EXPOSE 8989 8990

HEALTHCHECK --interval=5s --timeout=3s CMD curl --fail http://localhost:8989/health || exit 1

ENTRYPOINT [ "./graphhopper.sh", "-c", "config-example.yml" ]
