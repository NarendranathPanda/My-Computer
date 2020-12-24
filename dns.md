# DNS - Domain Name System 
when you map a ip address to to name and vice-versa 
Key points 
# 1. In linux machine that is done in the file  `/etc/hosts`

below example says the current host can ping the db server by a name called db
```
cat >>/etc/hosts
192.2.20.48 db

```
- This solution makes it believe for the host machine to map the <ip> is for DB , for that matter it can be named anything 
- When this ip will change this needs to be updated in all the connected serves 
- for a simple setup above solution works , but when we have 100s of machine this is not a maintainable solution 

# 2. DNS Server 
    Rather than putting all these configuration in every server , this can be stored at one place and every machine can get the name resolution from that server that is called DNS server 

- In the host machine we have to update the DNS server ip address at `/etc/resolve.conf`
- ``` nameserver <ip> ```

# Case -1 : When  the system is hosted locally but playing a role (i.e DB, web , cache.... etc )
- update the /etc/hosts file with ip and name (desired name)
# Case -2 : Lots of servers 
- updtae the configuration at DNS server and connect your host to the DNS server 
# Case -3 : When both the configuration have the same entry what is the preference 
- Perfernce of choosing the target ip address for a DNS is decided based on the order of entry in the file at `/etc/nsswitch.conf` and the entry for the hosts 
  ```hosts:          files dns```
- In the above case it will be resolved with the ip address mentioned at /etc/hosts file 
otherwise it will be dns server configuration 
# Case -4 : If the dns is not mentioned in any of the configuration 
In that case it will not resolve ,
- Option 1 : 
    - if we want this to be checked in the public DNS server (DNS) then make the following entry for public DNS server at `/etc/resolv.conf` (examle google dns server 8.8.8.8)
    ```nameserver 8.8.8.8 ```
    - In that case you have to update all the servers resolv.conf file 
- Option 2 : Put the configuration with the DNS server 
    ``` Forward All to 8.8.8.8 ``` 

# What are these Domain Names 
 For example : www.google.com , maps.google.com, mails.google.com, drive.google.com, apps.google.com
 
1. root `.`
2. Top level domain `.com` ,`google`
3. Sub domain `www` ,`map` ,`mail`, `drive`, `apps`
 
These entry structures for the server access outside of the organisation 

but inside the organisation we may stil call our servers with the short name 

for example , when I say web.mycompany.com it points to the web server , but when I want to say only web I want that to point to the web server too 
for that make the following entry at `/etc/resolv.conf`
``` search mycompany.com ```

# Record types stored in the DNS server 
- 3 types majorly  
1. A record `A <name> <ipv4>`
2. AAAA record `AAAA <name> <ipv6>`
3. CNAME record `CNAME <name1> <name2>`

# Files and paths 
```
cat /etc/hosts
cat /etc/resolv.conf
cat /etc/nsswitch.conf
```

# Testing tools 
# nslookup 
- command : `nslookup www.google.com`
- note: This will not fetch if any entry made in the /etc/hosts
# dig
  - command: `dig www.google.com`

- ref : https://docs.google.com/document/d/1j-0IEMDR74CWDQ5B0ohmqmeTwkBlmo4SAmRxW7fKPVs/edit?usp=sharing
- ref: https://www.unixmen.com/setting-dns-server-centos-7/








