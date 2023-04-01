build:
	bash ./build.sh false

run:
# Nepal url: http://download.geofabrik.de/asia/nepal-latest.osm.pbf
# Kathmandu: N/A
# Ontario: https://download.geofabrik.de/north-america/canada/ontario-latest.osm.pbf
# South-western ontario: https://download.openstreetmap.fr/extracts/north-america/canada/ontario/southwestern_ontario-latest.osm.pbf
	docker run -p 8989:8989 graphhopper:latest \
		--url http://download.geofabrik.de/asia/nepal-230306.osm.pbf \
		--host 0.0.0.0
