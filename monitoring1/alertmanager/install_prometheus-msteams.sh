DEFAULT_URL=https://github.com/prometheus-msteams/prometheus-msteams/releases/download/v1.4.1/prometheus-msteams-linux-amd64

read -p "Enter your Latest prom-msteam URL from : https://github.com/prometheus-msteams/prometheus-msteams/releases [prometheus-msteams-v1.4.1]: " name

PROM_MSTEAM_URL=${name:-$DEFAULT_URL}
PROM_MSTEAM_DIR=/opt/prometheus-msteams
PROM_MSTEAM_UID=prometheus_msteams
PROM_MSTEAM_GID=prometheus_msteams
mkdir -p $PROM_MSTEAM_DIR

wget $PROM_MSTEAM_URL;
chmod +x prometheus-msteams-linux-amd64
mv prometheus-msteams-linux-amd64 $PROM_MSTEAM_DIR/promteams

cp ../artifacts/msteams_web_hook_channel.yaml $PROM_MSTEAM_DIR/
cp ../artifacts/default-message-card.tmpl $PROM_MSTEAM_DIR/

cat <<EOF >/etc/systemd/system/prometheus-msteams.service
[Unit]
Description=prometheus-msteams
Wants=network-online.target
After=network-online.target

[Service]
User=$PROM_MSTEAM_UID
Group=$PROM_MSTEAM_GID
Type=simple
WorkingDirectory=$$PROM_MSTEAM_DIR
ExecStart=$PROM_MSTEAM_DIR/promteams \
           -config-file $PROM_MSTEAM_DIR/msteams_web_hook_channel.yaml \
           -template-file $PROM_MSTEAM_DIR/default-message-card.tmpl
[Install]
WantedBy=multi-user.target
EOF


sudo useradd -rs /bin/false $PROM_MSTEAM_UID
sudo chown $PROM_MSTEAM_UID:$PROM_MSTEAM_GID $PROM_MSTEAM_DIR
sudo systemctl daemon-reload
sudo systemctl enable prometheus-msteams.service
sudo service prometheus-msteams.service start
sudo service prometheus-msteams.service status


