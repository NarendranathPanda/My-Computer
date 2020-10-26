# Kubernetes Installation: (Singlenode k8s cluster)
 Create 1 AWS ubuntu VM (t2 medium)

## Step 1.
 Run following command We need to install kubeadm,kubectl,kubelet and cni

```
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
```

## Update and install docker
```
apt-get update
apt-get install -y docker.io
apt-get install -y kubelet kubeadm kubectl kubernetes-cni

```

(Some important process in kubernetes.
kubeadm: command to bootstrap the cluster.
kubelet: component that runs on all of the machines in your cluster and does things like starting pods and containers.
kubectl: command line utility to talk to your cluster.
kubernetes-cni: used for kubernetes networking)


## Step 2. 
Run following command on Master VM (VM1) only
```
kubeadm init

```
#Copy kubeadm join output command in notepad for further adding worker nodes 
#(It will look like... kubeadm join --token ef6acb.11b6129ab3a2fbe0 172.31.22.102:6443 --discovery-token-ca-cert-hash sha256:e83e2872f599eea6b13d42a7b4a01a55958a78c6439192c8d2bb4578797de686 )

## Step 3.
Run following command on Node
```
sudo cp /etc/kubernetes/admin.conf $HOME/
sudo chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf
kubectl apply -f https://cloud.weave.works/k8s/net?k8s-version=1.10
```

## Step 4.
To restarting kubelet run following command (VM1)
```
systemctl daemon-reload
systemctl restart kubelet

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl apply -f https://git.io/weave-kube-1.6
```
kubectl Cluster-info
```
