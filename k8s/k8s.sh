#! /bin/bash
kube=$1
if [ -z $kube ];then
 echo  "Select the  environment: "
 echo "--------------------------------------------"
 ls -XA1 ~/.kube/
 echo "--------------------------------------------"
 echo -n "Env : "
 read kube
fi

kube="${kube:-config}"
export KUBECONFIG=~/.kube/$kube
#ref : https://stackoverflow.com/questions/50406142/kubectl-bash-completion-doesnt-work-in-ubuntu-docker-container
source /etc/bash_completion
alias k=kubectl
complete -F __start_kubectl k
source <(kubectl completion bash | sed 's/kubectl/k/g')

echo "------------------cluster-info--------------------------"

export do="-o yaml --dry-run=client"

k cluster-info

echo "------------------context-info--------------------------"

k config get-contexts

echo "--------------------------------------------------------"
echo ""

