# Graphhopper docker provider repository
This repository holds the very basic things in order to make sure there's an updated graphhopper docker image which we use in our production server.

I would like to first and foremost thank the [graphhopper](https://www.graphhopper.com/) team for their hard work and amazing product!
They are doing a great job and we are truly happy to help by contributing to thier code base like we had done in the past.

This docker image uses the following default environment setting:
```
JAVA_OPTS: "-Xmx1g -Xms1g"
```

For a quick startup you can run the following command to create the andorra routing:
```
docker run -p 8989:8989 routing-engine:latest --url https://download.geofabrik.de/north-america/canada/ontario-latest.osm.pbf --host 0.0.0.0
```
Then surf to `http://localhost:8989/`

You can also completely override the entry point and use this for example:
```
docker run --entrypoint /bin/bash routing-engine -c "wget https://download.geofabrik.de/north-america/canada/ontario-latest.osm.pbf -O /data/ontario.osm.pbf && java -Ddw.graphhopper.datareader.file=/data/ontario.osm.pbf -Ddw.graphhopper.graph.location=berlin-gh -jar *.jar server config-example.yml"
```

Checkout `graphhopper.sh` for more usage options such as import.

In order to build the docker image locally, please run [`.github/build.sh`](.github/build.sh).

## osm.pbf Data sources

- https://download.geofabrik.de/
- https://download.openstreetmap.fr/extracts/
