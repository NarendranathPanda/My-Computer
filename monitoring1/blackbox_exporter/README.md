At one point or another, expired certificates have caused a problem. In theory, they shouldn’t; the exact expiration date is known, and so is the process for updating. But still the problems persist! 

Monitor the expiration date of certificates with Prometheus and visualize it with Grafana, using features from the new table visualization in Grafana 7.

- ref: https://grafana.com/blog/2020/11/25/how-we-eliminated-service-outages-from-certificate-expired-by-setting-up-alerts-with-grafana-and-prometheus/
- ref: https://github.com/prometheus/blackbox_exporter/blob/master/blackbox.yml
- ref: https://grafana.com/grafana/dashboards/13230

- Copy the Service file to : /usr/local/bin/blackbox_exporter 
- Copy the backbox-exprter config(blackbox.yml) at : /etc/blackbox_exporter/blackbox.yml
- ref the [prometheus.yml](prometheus.yml) for your configuring the target
- ref the alerting rule  [cert-alert.yml](cert-alert.yml)

