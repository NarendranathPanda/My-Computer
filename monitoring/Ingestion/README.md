ref: https://www.robustperception.io/using-the-remote-write-path
# Objective : 
    - Test the Remote Read Write 
# Env: 
    - Docker Desktop (Windows/ Powershell)

# Spin a prometheus container 

```
docker run --rm -d -p 9090:9090 -v ${PWD}/prometheus.yml:/etc/prometheus/prometheus.yml --name=prom prom/prometheus
```

# Spin a prometheus(central) container 

```
docker stop prom-server-central
docker run --rm -d -p 80:9090 -v ${PWD}/server/prometheus.yml:/etc/prometheus/prometheus.yml --name=prom-server-central prom/prometheus
```


# Spin another prometheus with remote write enabled
```
docker stop prom-edge-1
docker run --rm -d -p 9091:9090 -v ${PWD}/edge/prometheus.yml:/etc/prometheus/prometheus.yml --name=prom-edge-1 prom/prometheus
```
