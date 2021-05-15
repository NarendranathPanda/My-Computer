#### Learn more about HA-PROXY mTLS

#### Set up the kind cluster 
```
kind create cluster --config=kind-config.yaml --image kindest/node:v1.20.2
alias k=kubectl
```

#### Create the Namespaces
```
k apply -f main/
```

#### Install HA-PROXY Ingress Controller  

```
helm repo add haproxytech https://haproxytech.github.io/helm-charts
helm repo update
helm search repo haproxy

#### Installation 
helm install -n haproxy-controller haproxy haproxytech/kubernetes-ingress \
 --set controller.kind=DaemonSet \
 --set controller.daemonset.useHostPort=true 

#### Update 
helm upgrade haproxy -n haproxy-controller haproxytech/kubernetes-ingress \
 --set controller.kind=DaemonSet \
 --set controller.daemonset.useHostPort=true 

#### Remove
helm uninstall haproxy 
 
```
#### Create the certificates 
[Make sure the CN and SAN must be matching -click for details](https://github.com/jcmoraisjr/haproxy-ingress/issues/380#issuecomment-529899442)

#### For HA-PROXY (default)
```
openssl req -x509 \
-newkey rsa:2048 \
-keyout resources/naren.key \
-out resources/naren.crt \
-days 365 \
-nodes \
-subj "/C=IN/ST=KA/L=BLR/O=default/CN=naren.local"
```
#### For app1
```
openssl req -x509 \
-newkey rsa:2048 \
-keyout resources/app1.naren.key \
-out resources/app1.naren.crt \
-days 365 \
-nodes \
-subj "/C=IN/ST=KA/L=BLR/O=app1/CN=app1.naren.local"
```
#### For app2
```
openssl req -x509 \
-newkey rsa:2048 \
-keyout resources/app2.naren.key \
-out resources/app2.naren.crt \
-days 365 \
-nodes \
-subj "/C=IN/ST=KA/L=BLR/O=app2/CN=app2.naren.local"
```
#### Check the certificates
```
openssl x509 -in $NAME.crt -text -noout

```
#### Create the Kubernetes secret

```
#### For ha-proxy default

kubectl create secret tls  -n haproxy-controller default-tls-secret \
  --cert=resources/naren.crt \
  --key=resources/naren.key

#### for app1 

kubectl create secret tls -n app1 app1-tls-secret \
  --cert=resources/app1.naren.crt \
  --key=resources/app1.naren.key 

#### for app2 
kubectl create secret tls -n app2 app2-tls-secret \
  --cert=resources/app2.naren.crt \
  --key=resources/app2.naren.key   
```

#### Update the default certificate of ha-proxy

```
k edit cm haproxy-kubernetes-ingress -n haproxy-controller
#### create/update below content 
data:
 ssl-certificate: "haproxy-controller/default-tls-secret"

```

#### Deploy the application 
```

k apply -f app1/
k apply -f app2/

```

#### Update the hosts 
```
127.0.0.1 app1.naren.local
127.0.0.1 app2.naren.local
```

#### Test the app 
Access the website
- default: `curl -v https://app.naren.local`
- app1   : `curl -v https://app1.naren.local/`
- app2   : `curl -v https://app2.naren.local/`


#### REF: 
 - https://cloud.google.com/kubernetes-engine/docs/how-to/ingress-multi-ssl
 - https://www.haproxy.com/blog/dissecting-the-haproxy-kubernetes-ingress-controller/
 - https://www.haproxy.com/static/pdf/HAProxy_in_Kubernetes_-_Supercharge_Your_Ingress_Routing.zip