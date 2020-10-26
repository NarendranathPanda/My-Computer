# Kubernetes Installation:
 Create 1 AWS ubuntu VM (t2 medium for master) and 1 more ec2 instance (t2micro for node)

## Step 1.
 Run following command on Master and Node VM (VM1 & VM2), We need to install kubeadm,kubectl,kubelet and cni

```
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
```

## Update both the Instances and install docker
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
#Copy kubeadm join output command in notepad
#(It will look like... kubeadm join --token ef6acb.11b6129ab3a2fbe0 172.31.22.102:6443 --discovery-token-ca-cert-hash sha256:e83e2872f599eea6b13d42a7b4a01a55958a78c6439192c8d2bb4578797de686 )

## Step 3.
Run following command on Master VM (VM1)
```
sudo cp /etc/kubernetes/admin.conf $HOME/
sudo chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf
kubectl apply -f https://cloud.weave.works/k8s/net?k8s-version=1.10
```

## Step 4.
To Docker cgroup driver matches the kubelet config (VM1)
```
docker info | grep -i cgroup
cat /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
```

## Step 5.
Change the kubelet config to match the Docker cgroup drive (VM1)
```
sed -i "s/cgroup-driver=systemd/cgroup-driver=cgroupfs/g" /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
```

## Step 6.
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
## Step 7.
Run kubeadm join output command on node VM (VM2) (copy output command from step 2).
   Once you run kubeadm join command (Token) on Node VM, your VM will become part of Kubernetes cluster.

```
kubectl Cluster-info

```



# Notes 

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 172.31.67.65:6443 --token ctu9ew.ogotsrgmvtg2qf49 \
    --discovery-token-ca-cert-hash sha256:0302059adfbef5d9df0f6c59b4da78495a8e423189fcb95f1aeedf97a5a28582


