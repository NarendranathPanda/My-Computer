# Generate the certificate using open ssl 
```
openssl req -new -newkey rsa:2048 -nodes -keyout ca.key -out ca.csr
```


##### Collect the 
- ca.key (privatekey.key)
- ca.csr
keep the password with you 

# Create the Certificate Signing Request for your CA
In return you will get .cer 

# Convert the .cer file to jks
#1. Convert .csr to pfx format 
```
mkdir https-jks
cd https-jks
```
You should have following files in place 
- privatekey.key //Keep the ca.key (privatekey.key) which from the step -1
- certificate.cer // This one you will get it from CA

```
openssl pkcs12 -export -in certificate.cer -inkey privatekey.key -out certificate.pfx
```
Use the password that you have set at the time of generating the csr for ```Enter source keystore password:```

#2. Convert From pfx format to jks format 
```
keytool -importkeystore -srckeystore certificate.pfx -srcstoretype pkcs12 -destkeystore jenkins-keystore.jks -deststoretype JKS
```
Set the Password in this process (```PASSWORD```) // this will be feeded to Jenkins settings

```
copy the file to /var/lib/jenkins/keystore/

```

#3. Edit the /etc/sysconfig/jenkins file to pick the new certificate 

Update this two variables in the file 
```
JENKINS_HTTPS_KEYSTORE="/var/lib/jenkins/keystore/jenkins-keystore.jks"
JENKINS_HTTPS_KEYSTORE_PASSWORD="PASSWORD"
```
Restart the jenkins

Try to connect to jenkins via https
