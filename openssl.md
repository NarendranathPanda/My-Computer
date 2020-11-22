# Use OpenSSL to generate certificate 
- ref: https://www.youtube.com/watch?v=wzbf9ldvBjM&t=4s&ab_channel=TutorialsPedia
- ref: https://github.com/mmumshad/kubernetes-the-hard-way/blob/master/docs/04-certificate-authority.md
- ref: https://kubernetes.io/docs/concepts/cluster-administration/certificates/

# Download openSSL utility 
1. https://github.com/openssl/openssl/releases
2. https://www.openssl.org/

# MAN Page
1. https://linux.die.net/man/1/openssl

# Simple steps 
1. Generate the key
2. Extract the public key 
3. Generate CSR (Certificate Signing Request )
4. Generate the Self-Signed Certificate 

# Generate the key i.e ca.key
```openssl genrsa -out ca.key 2048```

# Extract the public key 
```openssl rsa -in ca.key -pubout -out ca.pem```

# Create CSR using the private key
```openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr```

# Self sign the csr using its own private key
```openssl x509 -req -in ca.csr -signkey ca.key -CAcreateserial  -out ca.crt -days 1000```

# verification 
```openssl x509  -noout -text -in ./ca.crt ```


Tips:  To add Alias in the certificate 
# OpenSSl conf file 
ref : https://github.com/openssl/openssl/blob/master/apps/openssl.cnf
```openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr -config openssl.cnf```



