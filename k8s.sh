#! /bin/bash
kube=$1
if [ -z $kube];then
 echo  "Select the  environment: "
 echo "--------------------------------------------"
 ls -XA1 ~/.kube/
 echo "--------------------------------------------"
 echo -n "Env : "
 read kube
fi

kube="${kube:-config}"
export KUBECONFIG=~/.kube/$kube
alias k=kubectl
complete -F __start_kubectl k
source <(kubectl completion bash | sed 's/kubectl/k/g')

echo "------------------cluster-info--------------------------"

k cluster-info

echo "------------------context-info--------------------------"

k config get-contexts

echo "--------------------------------------------------------"
echo ""

