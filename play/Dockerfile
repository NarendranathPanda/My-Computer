FROM centos/tools
COPY . .
RUN yum install git tree epel-release python3 ansible java maven jq wget kubectl -y
RUN wget https://get.helm.sh/helm-v3.3.4-linux-amd64.tar.gz  && tar -zxvf helm-v3.3.4-linux-amd64.tar.gz && mv linux-amd64/helm /usr/local/bin/helm && rm -rf linux-amd64 helm-v3.3.4-linux-amd64.tar.gz  


