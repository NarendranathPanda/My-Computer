ARG PROM_PATH=/tmp/
FROM prom/node-exporter:v1.0.1

USER        nobody
ENTRYPOINT  [ "/bin/node_exporter", "--collector.textfile.directory", "${PROM_PATH}"]
