#! /bin/bash

echo  "Select the  environment: "
ls -X ~/.kube/
echo -n "Env : "
read kube
export KUBECONFIG=~/.kube/$kube
alias k=kubectl
complete -F __start_kubectl k

k cluster-info
k config get-contexts
