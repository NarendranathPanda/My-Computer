##### Harbor Installation #####
https://cormachogan.com/2020/12/01/deploying-harbor-v2-1-0-step-by-step/
```

adduser npanda
usermod -aG sudo npanda

# https://docs.docker.com/engine/install/ubuntu/
sudo apt-get update

sudo apt-get remove docker docker-engine docker.io containerd runc

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
   
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

sudo apt-get install docker-ce docker-ce-cli containerd.io

    
sudo usermod -aG docker npanda
sudo systemctl restart docker

sudo curl -L "https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
sudo apt install net-tools



```
#### Install harbor ####
```
cd ~/
wget  https://github.com/goharbor/harbor/releases/download/v2.1.3/harbor-online-installer-v2.1.3.tgz
tar xvf harbor-online-installer-v2.1.3.tgz

openssl genrsa -out ca.key 4096

openssl req -x509 -new -nodes -sha512 -days 3650 \
 -subj "/C=IN/ST=KA/L=BLR/O=Naren/OU=Personal/CN=naren.local.com" \
 -key ca.key \
 -out ca.crt
 
 
 openssl genrsa -out registry-1.naren.local.com.key 4096
 openssl genrsa -out registry-2.naren.local.com.key 4096
 
 
 openssl req -sha512 -new \
    -subj "/C=IN/ST=KA/L=BLR/O=Naren/OU=Personal/CN=naren.local.com" \
    -key registry-1.naren.local.com.key \
    -out registry-1.naren.local.com.csr
 openssl req -sha512 -new \
    -subj "/C=IN/ST=KA/L=BLR/O=Naren/OU=Personal/CN=naren.local.com" \
    -key registry-2.naren.local.com.key \
    -out registry-2.naren.local.com.csr	
	
cat > v3.ext <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1=registry-2.naren.local.com
DNS.2=naren.local.com
DNS.3=registry-2
EOF	

cat > v3.ext <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1=registry-1.naren.local.com
DNS.2=naren.local.com
DNS.3=registry-1
EOF	



openssl x509 -req -sha512 -days 3650 \
    -extfile v3.ext \
    -CA ca.crt -CAkey ca.key -CAcreateserial \
    -in registry-1.naren.local.com.csr \
    -out registry-1.naren.local.com.crt
	
openssl x509 -req -sha512 -days 3650 \
    -extfile v3.ext \
    -CA ca.crt -CAkey ca.key -CAcreateserial \
    -in registry-2.naren.local.com.csr \
    -out registry-2.naren.local.com.crt	

sudo mkdir -p /data/cert/

sudo cp registry-1.naren.local.com.crt /data/cert/
sudo cp registry-1.naren.local.com.key /data/cert/
 
sudo cp registry-2.naren.local.com.crt /data/cert/
sudo cp registry-2.naren.local.com.key /data/cert/
 
openssl x509 -inform PEM -in registry-1.naren.local.com.crt -out registry-1.naren.local.com.cert
openssl x509 -inform PEM -in registry-2.naren.local.com.crt -out registry-2.naren.local.com.cert
 

 sudo mkdir -p /etc/docker/certs.d/registry-1.naren.local.com/
 sudo mkdir -p /etc/docker/certs.d/registry-2.naren.local.com/

sudo cp registry-1.naren.local.com.cert /etc/docker/certs.d/registry-1.naren.local.com/
sudo cp registry-1.naren.local.com.key /etc/docker/certs.d/registry-1.naren.local.com/
sudo cp ca.crt /etc/docker/certs.d/registry-1.naren.local.com/

sudo cp registry-2.naren.local.com.cert /etc/docker/certs.d/registry-2.naren.local.com/
sudo cp registry-2.naren.local.com.key /etc/docker/certs.d/registry-2.naren.local.com/
sudo cp ca.crt /etc/docker/certs.d/registry-2.naren.local.com/

 

cd /home/npanda/harbor/
cp harbor.yml.tmpl harbor.yml

#update three keys: 
#hostname: registry-1.naren.local.com
#certificate: /data/cert/registry-1.naren.local.com.crt
#private_key: /data/cert/registry-1.naren.local.com.key



registry.naren.local.com


tune.ssl.default-dh-param 4096   # set 4096 bits for Diffie-Hellman key



 
```

# https://github.com/goharbor/harbor/issues/6405
# https://medium.com/@ikod/deploy-harbor-container-registry-in-production-89352fb1a114
# https://raw.githubusercontent.com/cormachogan/harbor-certs/main/gen-harbor-certs.sh
# https://neonmirrors.net/post/2020-10/deploying-harbor-on-photon-os/ 
# https://cormachogan.com/2020/12/01/deploying-harbor-v2-1-0-step-by-step/
# https://github.com/goharbor/harbor/issues/3791
# https://www.claudiokuenzler.com/blog/958/running-harbor-registry-behind-reverse-proxy-solve-docker-push-errors
