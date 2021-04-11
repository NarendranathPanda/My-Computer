#!/bin/bash

#########################################
#
#-- Create all necessary certs any web-server
#
#-- Author: Narendranath Panda
#
#-- Version 1.0 (31-Jan-2021)
#
#########################################
clear
echo
echo "*************************************************************"
echo "***                                                       ***"
echo "*** Script to create CA cert and private key, server CSR, ***"
echo "*** x509 ext file, and certs for any Web Server           ***"
echo "***                                                       ***"
echo "*************************************************************"
echo
function check_deps()
{
        which openssl > /dev/null 2>&1
        if [ $? -ne 0 ]
        then
                echo "openssl is not installed, or is not in the PATH, exiting ..."
                exit
        fi
}

echo "-- Step 0: Checking dependencies ..."
check_deps

echo
echo "Type in the fully qualified domain name  (e.g. n4b.com): "
read fqdn

if [ -z "$fqdn" ]
then
        echo "no fqdn supplied"
        exit
fi

echo
echo "Step 1 - Generate a CA Cert"
echo
echo "Step 1.1 -  Generate a CA Cert Private Key"
echo
 sudo openssl genrsa -out ca.key 4096
echo
echo "Step 1.2 -  Generate a CA Cert Certificate. (change the subject if you want /C=IN/ST=KA/L=BLR/O=Naren/OU=Personal)"
echo
 sudo openssl req -x509 -new -nodes -sha512 -days 3650 -subj "/C=IN/ST=KA/L=BLR/O=Naren/OU=Personal/CN=${fqdn}"  -key ca.key -out ca.crt
echo
echo "Check the ca.key and ca.crt . Hit enter to continue";read null
echo
echo "Step 2 - Generate a Server Certificate"
echo
echo "Step 2.1 - Generate a Server Certificate Private Key"
echo
 sudo openssl genrsa -out ${fqdn}.key 4096
echo
echo "Step 2.2 - Generate a Server Certificate Signing Request"
echo
 sudo openssl req -sha512 -new \
         -subj "/C=IN/ST=KA/L=BLR/O=Naren/OU=Personal/CN=${fqdn}" \
         -key ${fqdn}.key \
         -out ${fqdn}.csr
echo
echo "Step 2.3 -Done!  Find the files"
 sudo ls -lrt
