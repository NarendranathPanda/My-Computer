# install_prometheus_centos_static
Install Prometheus on standalone centos machine

```

# you should have sudo access 
cd /tmp
git clone https://github.com/NarendranathPanda/install_prometheus_centos_static.git
cd install_prometheus_centos_static
# Edit the file install_prometheus.sh file to if you want to use someother version of prometehus other than `v2.10.0` 
FULL_URL=https://github.com/prometheus/prometheus/releases/download/v2.22.0/prometheus-2.22.0.linux-amd64.tar.gz
PROMETHEUS_BASE_URL=https://github.com/prometheus/prometheus/releases/download;
PROMETHEUS_VERSION=v2.10.0; # update the version number to the latest if you wish
PROMETHEUS_GZ_FILENAME=prometheus-2.10.0.linux-amd64 # Update the correct file name if you wish

chmod 777 install_prometheus.sh
sh install_prometheus.sh
service prometheus status

curl http://localhost:9090

# wait for few miniutes the url should be up 

```

