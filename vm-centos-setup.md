# Setting up the static network in the centos vm 

 Get the VDI image ref : https://www.osboxes.org/centos/ 

https://sourceforge.net/projects/osboxes/files/v/vb/10-C-nt/7/7-1908/C_OS1908-VB-64bit.7z/download

## Network Adapter 1 
   1. Adapter 1:  Bridge Adater (this is for internet/ IP assigned by the dhcp of your network / and the ip address may change on reboot)
   ![Image of Yaktocat](/img/vm-centos-adater-1.PNG)
   2. Adapter 2: Hostonly Network (this is for communication among the vm )
   ![Image of Yaktocat](/img/vm-centos-adater-2.PNG))

Setup the enp0s8 network so that ip address will not change on every reboot 
ref: https://mikesmithers.wordpress.com/2018/11/17/virtualbox-configuring-a-host-only-network/ 

```
sudo vi /etc/sysconfig/network-scripts/ifcfg-en0s8
###############################
TYPE=ETHERNET
BOOTPROTO=none
DEFROUTE=yes
IPV4_FAILURE_FATAL=yes
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
DEVICE=enp0s8
ONBOOT=yes
IPADDR=192.168.56.123 # take the value from the setting of host-only adater 
PREFIX=24
GATEWAY=192.168.56.254 # take the value from the setting of host-only adater highset IP
IPV6_PEERDNS=yes
IPV6_PEERROUTES=yes
IPV6_PRIVACY=no
###############################
```   

![Image of Yaktocat](/img/host-only.PNG)

reboot the newtork 
``` systemctl restart network```
reboot the machine(vm)
```reboot```
