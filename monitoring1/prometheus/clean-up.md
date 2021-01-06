# prometheus-cleanup
The goal of this project is to cean of prometheus space
- ref:  https://prometheus.io/docs/prometheus/latest/querying/api/#delete-series
- ref : https://github.com/prometheus/prometheus/pull/2821
- ref : https://github.com/prometheus/prometheus/issues/5808
- ref : https://www.epochconverter.com/

# delete all metrics till time 
## v1:

```
curl -X POST -g 'http://localhost:9090/api/v1/admin/tsdb/delete_series?match[]={__name__=~".%2B"}'
```
`not working`
```
curl -X POST -g 'http://localhost:9090/api/v1/admin/tsdb/delete_series?match[]={__name__=~".%2B"}&start=1599136850&end=1599141720' 
```

## v2:
```
curl -X POST -g 'http://localhost:9090/api/v2/admin/tsdb/delete_series' -d '{"matchers": [{"name": "__name__", "type": 2, "value": ".+"}]}'
```

# Delete single metrics-series 
## v1:
```
#start -- start time Epoch time 
#end   -- end time Epoch time 
#match -- metric to delete 

curl -X POST   -g 'http://localhost:9090/api/v1/admin/tsdb/delete_series?match[]=up&start=1599136850&end=1599141448'


```

## v2:
```
curl -X POST -g 'http://localhost:9090/api/v2/admin/tsdb/delete_series' -d '{"matchers": [{"name": "__name__", "type": 2, "value": "up"}]}'
```
TODO `time range not sure `





