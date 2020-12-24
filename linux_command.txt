vi /root/.bashrc


export HTTP_PROXY=http://10.158.100.6:8080
export HTTPS_PROXY=http://10.158.100.6:8080
export NO_PROXY=localhost,127.0.0.1,docker-registry.vepro.nsn-rdnet.com,10.96.0.0/12,<<<<<<TODO IP>>>>>>

:wq!

source ~/.bashrc
. ~/.bashrc


# Install Docker CE

sudo yum install -y yum-utils device-mapper-persistent-data lvm2
# Install docker Repo 

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# Install docker 
sudo yum install docker-ce docker-ce-cli containerd.io

## Create /etc/docker directory.
mkdir /etc/docker


# Make docker as a service 
mkdir -p /etc/systemd/system/docker.service.d
systemctl enable docker.service

# Restart Docker
systemctl daemon-reload
systemctl restart docker

# Check Docker installed 
sudo docker run hello-world

# Add Kubernets repo 
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF

# Set SELinux in permissive mode (effectively disabling it)
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

systemctl enable --now kubelet
systemctl enable docker.service

kubeadm init 

kubectl -n kube-system apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml

kubeadm join 192.168.0.5:6443 --token y3s7tq.979zs5qaspi9vtuz \
    --discovery-token-ca-cert-hash sha256:a21de4eb859ec10d1efb7457dcc3759446cf04803a483ae2eb7e9cd860910ffb






