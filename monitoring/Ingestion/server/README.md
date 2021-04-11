ref: https://github.com/prometheus/prometheus/tree/release-2.24/documentation/examples/remote_storage/example_write_adapter

## Remote Write Adapter Example

```
docker build --target dev . -t rw-server
docker run --name=rw-server --rm -it -d -p 80:1234 -v ${PWD}:/work rw-server 
```
...and then add the following to your `prometheus.yml`:

```yaml
remote_write:
  - url: "http://localhost:1234/receive"
```

Then start Prometheus:

```
./prometheus
```