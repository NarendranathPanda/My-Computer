#! /bin/bash

echo  "Select the  environment: "
echo "--------------------------------------------"

ls -XA1 ~/.kube/k8s

echo "--------------------------------------------"

echo -n "Env : "
read kube
kube="${kube:-config}"
export KUBECONFIG=~/.kube/k8s/$kube
alias k=kubectl
complete -F __start_kubectl k
source <(kubectl completion bash | sed 's/kubectl/k/g')

echo "------------------cluster-info--------------------------"

k cluster-info

echo "------------------context-info--------------------------"

k config get-contexts

echo "--------------------------------------------------------"
echo ""

