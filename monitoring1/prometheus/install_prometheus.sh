#!bin/bash

PROM_DEFAULT_URL=https://github.com/prometheus/prometheus/releases/download/v2.22.0/prometheus-2.22.0.linux-amd64.tar.gz
PROM_UID=prometheus
PROM_GID=prometheus
PROM_CONFIG_DIR=/etc/prometheus
PROM_DATA_DIR=/var/lib/prometheus
PROM_EXPORTER_GZ_FILENAME=prometheus.tar.gz

read -p "Enter your Latest prometheus URL from : https://prometheus.io/download/#prometheus [prometheus-2.22.0]: " name
PROM_URL=${name:-$PROM_DEFAULT_URL}

# Create a group with the name prometheus as that of user prometheus and add the user to the prometheus group
sudo useradd -Urs /bin/false prometheus
echo "Created user prometheus";

#rm -rf $PROM_DATA_DIR $PROM_CONFIG_DIR $PROM_CONFIG_DIR/alerts
mkdir $PROM_DATA_DIR $PROM_CONFIG_DIR $PROM_CONFIG_DIR/alerts
chown -R $PROM_UID:$PROM_GID $PROM_DATA_DIR $PROM_CONFIG_DIR
chmod -R 775 $PROM_DATA_DIR $PROM_CONFIG_DIR


wget -O $PROM_EXPORTER_GZ_FILENAME $PROM_URL;
tar -xvf $PROM_EXPORTER_GZ_FILENAME 
cd prom*/ 
chmod +x prometheus
chmod +x promtool
mv prometheus /usr/local/bin/
mv promtool /usr/local/bin/
mv consoles $PROM_CONFIG_DIR/consoles ;
mv console_libraries  $PROM_CONFIG_DIR/console_libraries ;

cat <<EOF > $PROM_CONFIG_DIR/prometheus.yml
global:
  scrape_interval: 15s
  scrape_timeout: 10s
  evaluation_interval: 15s
alerting:
  alertmanagers:
  - static_configs:
    - targets: [localhost:9093]
    scheme: http
    timeout: 10s
    api_version: v1
rule_files:
- /etc/prometheus/alerts/*.yml	
scrape_configs:
- job_name: prometheus
  honor_timestamps: true
  scrape_interval: 15s
  scrape_timeout: 10s
  metrics_path: /metrics
  scheme: http
  static_configs:
  - targets:
    - localhost:9090
EOF
	
cat <<EOF > /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus Server
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
restart=always

ExecStart=/usr/local/bin/prometheus \
    --config.file $PROM_CONFIG_DIR/prometheus.yml \
    --storage.tsdb.path $PROM_DATA_DIR/ \
    --web.console.templates=$PROM_CONFIG_DIR/consoles \
    --web.console.libraries=$PROM_CONFIG_DIR/console_libraries \
    --web.listen-address=:9090 \
    --storage.tsdb.retention.time=365d \
	--storage.tsdb.retention.size=75GB \
    --web.enable-admin-api \
    --web.enable-lifecycle \

[Install]
WantedBy=multi-user.target
EOF

cat <<EOF >$PROM_CONFIG_DIR/alerts/node_alerts.yml
groups:
  - name: Jenkins Node
    rules:
      - alert: Critical-Alert-LostConnectivityToTarget
        expr: up == 0
        for: 2m
        labels:
          severity: critical
        annotations:
          summary: "Critical-Alert: Lost Connectivity to the Target {{$labels.job}} : {{$labels.instance}}"
          description: "Critical-Alert: Lost Connectivity to the Target {{$labels.job}} : {{$labels.instance}}"
      - alert: Warning-Alert-HighNodeCPUUsage
        expr: 100 - (avg by (ndac_role,ndac_group,instance) (irate(node_cpu_seconds_total{mode="idle"}[2m]) ) * 100) > 75
        for: 2m
        labels:
          severity: warning
        annotations:
          summary: "Warning-Alert: CPU Usage of {{$labels.job}} : {{$labels.instance}} is more than 75%"
          description: "Warning-Alert: CPU Usage of {{$labels.job}} : {{$labels.instance}} is more than 75%"
      - alert: Critical-Alert-UltraHighNodeCPUUsage
        expr: 100 - (avg by (ndac_role,ndac_group,instance) (irate(node_cpu_seconds_total{mode="idle"}[2m]) ) * 100) > 85
        for: 2m
        labels:
          severity: critical
        annotations:
          summary: "Critical-Alert: CPU Usage of {{$labels.job}} : {{$labels.instance}} is more than 85%"
          description: "Critical-Alert: CPU Usage of {{$labels.job}} : {{$labels.instance}} is more than 85%"
      - alert: Warning-Alert-HighNodeMemoryUsage
        expr: (1-node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes) * 100 > 75
        for: 2m
        labels:
          severity: warning
        annotations:
          summary: "Warning-Alert: Memory Usage of {{$labels.job}} : {{$labels.instance}} is more than 75%"
          description: "Warning-Alert: Memory Usage of {{$labels.job}} : {{$labels.instance}} is more than 75%"
      - alert: Critical-Alert-UltraHighNodeMemoryUsage
        expr: (1-node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes) * 100 > 85
        for: 2m
        labels:
          severity: critical
        annotations:
          summary: "Critical-Alert: Memory Usage of {{$labels.job}} : {{$labels.instance}} is more than 85%"
          description: "Critical-Alert: Memory Usage of {{$labels.job}} : {{$labels.instance}} is more than 85%"
      - alert: Warning-Alert-HighNodeDiskUsage
        expr: (1- node_filesystem_free_bytes / node_filesystem_size_bytes) * 100 > 60
        for: 2m
        labels:
          severity: warning
        annotations:
          summary: "Warning-Alert:Disk Usage of {{$labels.job}} : {{$labels.instance}} is more than 60%"
          description: "Warning-Alert: Disk Usage of {{$labels.job}} : {{$labels.instance}} is more than 60%"
      - alert: Critical-Alert-UltraHighNodeDiskUsage
        expr: (1- node_filesystem_free_bytes / node_filesystem_size_bytes) * 100 > 75
        for: 2m
        labels:
          severity: critical
        annotations:
          summary: "Critical-Alert: Disk Usage of {{$labels.job}} : {{$labels.instance}} is more than 75%"
          description: "Critical-Alert: Disk Usage of {{$labels.job}} : {{$labels.instance}} is more than 75%"
EOF

sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo service prometheus start
sudo service prometheus status
