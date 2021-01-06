mkdir -p /var/lib/node_exporter
echo 'role{role="application_server"} 1' > /tmp/domain.metric.prom.$$
mv /tmp/domain.metric.prom.$$ /var/lib/node_exporter/domain.metric.prom
