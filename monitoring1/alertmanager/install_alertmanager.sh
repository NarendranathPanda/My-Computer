ALERTMANAGER_DEFAULT_URL=https://github.com/prometheus/alertmanager/releases/download/v0.21.0/alertmanager-0.21.0.linux-amd64.tar.gz

read -p "Enter your Latest alertmanager URL from : https://prometheus.io/download/#alertmanager [alertmanager-0.21.0]: " name
ALERTMANAGER_URL=${name:-$ALERTMANAGER_DEFAULT_URL}
echo $ALERTMANAGER_URL

ALERTMANAGER_GZ_FILENAME=alertmanager.tar.gz
wget -O $ALERTMANAGER_GZ_FILENAME $ALERTMANAGER_URL;
tar -xvf $ALERTMANAGER_GZ_FILENAME 
cd alertmanager*/ 

sudo useradd -rs /bin/false alertmanager
sudo cp alertmanager /usr/local/bin/
sudo cp amtool /usr/local/bin/

sudo mkdir /etc/alertmanager
sudo cp ../artifacts/alertmanager.yml /etc/alertmanager/
sudo chown alertmanager:alertmanager /etc/alertmanager/
sudo chmod 777 /usr/local/bin/alertmanager
cat <<EOF > /etc/systemd/system/alertmanager.service
[Unit]
Description=Alertmanager
Wants=network-online.target
After=network-online.target

[Service]
User=alertmanager
Group=alertmanager
Type=simple
WorkingDirectory=/etc/alertmanager/
ExecStart=/usr/local/bin/alertmanager --config.file=/etc/alertmanager/alertmanager.yml --web.external-url http://0.0.0.0:9093

[Install]
WantedBy=multi-user.target

EOF

cd ..
rm -rf alertmanager-*.linux-amd64  $ALERTMANAGER_GZ_FILENAME
sudo systemctl daemon-reload
sudo systemctl enable alertmanager
sudo service alertmanager start
sudo service alertmanager status
