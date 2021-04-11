# Prometheus 

# Prometheus was not meant to provide:
## Long-term storage:
    Individual Prometheus instances provide durable storage of time series data, but they do not act as a distributed data storage system with features like cross-node replication and automatic repair. This means that durability guarantees are restricted to that of a single machine. Fortunately, Prometheus offers a remote write API that can be used to pipe time series data to other systems.
## A global view of data:
    As described in the bullet point above, Prometheus instances act as isolated data storage units. Prometheus instances can be federated but that adds a lot of complexity to a Prometheus setup and again, Prometheus simply wasn’t built as a distributed database. This means that there’s no simple path to achieving a single, consistent, “global” view of your time series data.
## Multi-tenancy: 
    Prometheus by itself has no built-in concept of a tenant. This means that it can’t provide any sort of fine-grained control over things like tenant-specific data access and resource usage quotas.


 ## Default Storage Model
    - wal 
    - chunk
 ## Limitation with Default Storage 	
    - Single disk storage : 
      - Can not withstand the hardware failure 
      - Disk corruption 
      - Node Outage
    - Horizontal Scale:  
      - Concorent read/write access to single file system
      -  `#TODO`
   - Replication:
     - Can not replicate the data 
     - No master slave model by Prometheus
 ## Challenges
    - Don't want to manage the storage at each cluster (Taking a snapshot , watching it regularly ) 
    - Complex Federation 
    - Achiving Single source of truth is complex 
    - Join Queries are challenging 
    - Check all the metrics in one view 
 ## Solution 
   ### Single Prometheus Instance to monitor all others
     - Single point of failure 
     - Collection of metrics at source is easy 
     - Avoid Overloading Prometheus  
   ### Remote Read/Write API
     - Prometheus provides API to remotely store the data 
     - Even if the remote is down , Prometheus keeps writing the data to local disk 
     - Once remote comes online it will sync up 
     - Memeory/CPU may increase in small properation 
   ### FAN OUT: Thanos 
     - Uses Side-Car 
   ### Centralised: Cortex, Victoria Metrics  
     - Uses Remote Read/Write API    
     - cortex needs a database to be setup (which will be additional overhead)
## Comparison 
### Metric Ingestion

   Head | Thanos | Vectoria Mertics
   --------|--------|----------------
   Operation | `Side-Car` based solution Uploads the 2hrs chunks to the S3| Uses Prometheus `Remote Read/Write API`
   Performance | Remote S3 can Scale pretty well | Horizontally Scaling by `vminsert` and `vmstorage`
   Reliability | Can Loase upto `2hrs` of data | Can loose upto `few seconds` of data. It uses sorted stream vs fsync used by WAL 


###  Querying Metrics 

   Head | Thanos | Vectoria Mertics
   --------|--------|----------------
   Operation | Thanos Querier Component Collects the metrics from each side-car(<2hr>) and the thanos store (>2hr) | Prometheus Querying  API (works out of the box )
   Performance | Depends on WAN. *Slowest prom/thanos = weakest snowball latency across multiple sites [AZ]   | Limted number of `vminsert` and `vmstorage` So Quantum is low , and usually local connection inside DB
   Scalability | Have more store gateway and Querier | Horizontally scale `vminsert` and `vmstorage`

*Notes: Query performance will get affected if anyone of the thanos side car slows down because of it's own prometheus performance issue

### Cost 
   Head | Thanos | Vectoria Mertics
   --------|--------|----------------
   Storage | Uses OpenTSDB format usually takes more space but S3 storage is cheaper | It compacts the data regularly data and store. uses EBS storage. Additional  snapshoting cost. `#TODO`
   Network | Charged for all the network bandwidth | Same except S3 cost 



    

# Challenge #1: Architecture 
# Challenge #2: Configuration Management 
# Challenge #3: Security 
# Challenge #4: Networking(Performance)



References : 
- https://grafana.com/go/observabilitycon/the-evolution-of-prometheus-observability/
- https://grafana.com/blog/2020/01/07/promcon-eu-recap-fixing-remote-write/
- https://www.youtube.com/watch?v=b_pEevMAC3I&ab_channel=PrometheusMonitoring
- https://www.robustperception.io/using-the-remote-write-path
- https://docs.google.com/document/d/1JqrU3NjM9HoGLSTPYOvR217f5HBKBiJTqikEB9UiJL0/edit#heading=h.9wcrrpcpeoyc
- https://www.prometheus.io/blog/2019/10/10/remote-read-meets-streaming/

 



