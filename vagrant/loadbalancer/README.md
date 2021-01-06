## Bring up all the virtual machines
```
vagrant up
```

## Set up load balancer node
##### Install Haproxy
```
apt update && apt install -y haproxy
```
##### Configure haproxy
Append the below lines to **/etc/haproxy/haproxy.cfg**
```
frontend kubernetes-frontend
    bind 172.16.16.100:6443
    mode tcp
    option tcplog
    default_backend kubernetes-backend

backend kubernetes-backend
    mode tcp
    option tcp-check
    balance roundrobin
    server kmaster1 172.16.16.101:6443 check fall 3 rise 2
    
```
##### Restart haproxy service
```
systemctl restart haproxy
```
Note : 
LB : 172.16.16.100:6443
K8S Control Node: 172.16.16.101:6443