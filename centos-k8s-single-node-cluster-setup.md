# Set up the proxy 
-----------------------------------------------------------
	vi /root/.bashrc

	export HTTP_PROXY=<ip>
	export HTTPS_PROXY=<ip>
	export NO_PROXY=localhost,127.0.0.1,<<<<<<TODO your machine IP>>>>>>

#reload the bash
-----------------------------------------------------------
	source ~/.bashrc

# Set up and Installation of  Docker and Supporting software 
-----------------------------------------------------------
	sudo yum install -y yum-utils device-mapper-persistent-data lvm2
	
# Install docker Repo 
-----------------------------------------------------------
	sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install docker 
-----------------------------------------------------------
	sudo yum install docker-ce docker-ce-cli containerd.io

## Enable docker Service
-----------------------------------------------------------
	systemctl enable docker.service
	
# Check Docker installed 
-----------------------------------------------------------
sudo docker info

# Add Kubernets repo 
-----------------------------------------------------------
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
-----------------------------------------------------------
	setenforce 0
	sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
	
#install kubeadm, kubelet ,kubectl 
-----------------------------------------------------------
	yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

#enable the kubelet service
-----------------------------------------------------------
	systemctl enable  kubelet

Install the k8s - Cluster
-----------------------------------------------------------
	kubeadm init 

#install the flnnel (for Networking)
-----------------------------------------------------------
	kubectl -n kube-system apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml


#Restart the machine 
-----------------------------------------------------------

#Note down the kubeadm init output for future use
-----------------------------------------------------------
?? 

#Troubleshoot 
-----------------------------------------------------------

### Cgroup  issue :   
>Error message :  	"misconfiguration: kubelet cgroup driver: "cgroupfs" is different from docker cgroup driver: "systemd" 
>Solution :	 " Do not start the docker by your own , Let kubeadm start with proper arguments" 
### Networking issue (bridge/cni) :  
>Error Message : 	"network plugin is not ready: cni config uninitialized" 
>Solution: 	 install flannel  
		       kubectl -n kube-system apply -f 
		       https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml
