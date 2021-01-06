NODE_EXPORTER_DEFAULT_URL=https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz
read -p "Enter your Latest node exporter URL from : https://prometheus.io/download/#node_exporter [node_exporter-1.0.1]: " name
NODE_EXPORTER_URL=${name:-$NODE_EXPORTER_DEFAULT_URL}
echo $NODE_EXPORTER_URL

NODE_EXPORTER_GZ_FILENAME=node_exporter.tar.gz
wget -O $NODE_EXPORTER_GZ_FILENAME $NODE_EXPORTER_URL;
tar -xvf $NODE_EXPORTER_GZ_FILENAME 
cd node*/ 
chmod 777 node_exporter
mv node_exporter /usr/local/bin/


cat  <<EOF > /etc/systemd/system/node_exporter.service 
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

cd ..
rm -rf node_exporter-*.linux-amd64 $NODE_EXPORTER_GZ_FILENAME 

sudo useradd -rs /bin/false node_exporter
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo service node_exporter start
sudo service node_exporter status
