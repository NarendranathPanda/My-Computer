#OS Version 
cat /etc/os-release
# Update Ubuntu
sudo apt update

sudo apt install nginx
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw status
sudo ufw allow 'Nginx HTTPS'
sudo ufw status
sudo ufw allow 'Nginx Full'
sudo ufw allow 'OpenSSH'
sudo ufw status
systemctl status nginx

# Ip check
ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'
ip link
ip route
curl -4 icanhazip.com

# Install Prometheus and node-exporter

sudo useradd --no-create-home --shell /bin/false prometheus
sudo useradd --no-create-home --shell /bin/false node_exporter

sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus
cd ~
curl -LO https://github.com/prometheus/prometheus/releases/download/v2.0.0/prometheus-2.0.0.linux-amd64.tar.gz
sha256sum prometheus-2.0.0.linux-amd64.tar.gz
tar xvf prometheus-2.0.0.linux-amd64.tar.gz
sudo cp prometheus-2.0.0.linux-amd64/prometheus /usr/local/bin/
sudo cp prometheus-2.0.0.linux-amd64/promtool /usr/local/bin/

sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo cp -r prometheus-2.0.0.linux-amd64/consoles /etc/prometheus
sudo cp -r prometheus-2.0.0.linux-amd64/console_libraries /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries

rm -rf prometheus-2.0.0.linux-amd64.tar.gz prometheus-2.0.0.linux-amd64
sudo vi /etc/prometheus/prometheus.yml


#===========
# ref: res/prometheus.yml
#===========

sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml
sudo -u prometheus /usr/local/bin/prometheus     --config.file /etc/prometheus/prometheus.yml     --storage.tsdb.path /var/lib/prometheus/     --web.console.templates=/etc/prometheus/consoles     --web.console.libraries=/etc/prometheus/console_libraries

sudo vi /etc/systemd/system/prometheus.service

#==================
# ref : res/prometheus.service
#==================

sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl status prometheus
sudo systemctl enable prometheus

cd ~
curl -LO https://github.com/prometheus/node_exporter/releases/download/v0.15.1/node_exporter-0.15.1.linux-amd64.tar.gz
sha256sum node_exporter-0.15.1.linux-amd64.tar.gz
tar xvf node_exporter-0.15.1.linux-amd64.tar.gz
sudo cp node_exporter-0.15.1.linux-amd64/node_exporter /usr/local/bin
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
rm -rf node_exporter-0.15.1.linux-amd64.tar.gz node_exporter-0.15.1.linux-amd64

sudo vi /etc/systemd/system/node_exporter.service
#=================
# ref : res/node_exporter.service
#=================
export OPTIONS="--collector.textfile.directory /var/lib/node_exporter/textfile_collector"
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl status node_exporter


# Make password for accessing Prometheus
sudo apt-get update
sudo apt-get install apache2-utils
sudo htpasswd -c /etc/nginx/.htpasswd <user-id> # input <password>
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/prometheus
vi /etc/nginx/sites-available/prometheus
# ====================
# ref: res/etc-nginx-sites-available-prometheus
# =====================
sudo rm /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/prometheus /etc/nginx/sites-enabled/
sudo nginx -t



wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"

sudo apt update
sudo apt install grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
sudo systemctl status grafana-server

sudo netstat -tnlp

```
tcp6       0      0 :::9090                 :::*                    LISTEN      5631/prometheus
tcp6       0      0 :::9100                 :::*                    LISTEN      4969/node_exporter
tcp6       0      0 :::80                   :::*                    LISTEN      5841/nginx: worker
tcp6       0      0 :::22                   :::*                    LISTEN      933/sshd
tcp6       0      0 :::3000                 :::*                    LISTEN      28688/grafana-serve

```


