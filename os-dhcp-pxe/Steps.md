# Step:1 Install required packages for PXE Setup
```
yum install dhcp tftp tftp-server syslinux vsftpd xinetd

```
# Step:2 Configure DHCP Server for PXE
```
vi /etc/dhcp/dhcpd.conf

```
# Step:3 Edit and Config tftp server (/etc/xinetd.d/tftp)

TFTP (Trivial File Transfer Protocol ) is used to transfer files from data server to its clients without any kind of authentication. In case of PXE server setup tftp is used for bootstrap loading. To config tftp server, edit its configuration file ‘ /etc/xinetd.d/tftp’, change the parameter ‘disable = yes‘ to ‘disable = no’ and leave the other parameters as it is.

```
vi /etc/xinetd.d/tftp

```
# Step:4 Mount CentOS 7.x ISO file and copy its contents to local ftp server
```
mount -o loop CentOS-7-x86_64-DVD-1511.iso /mnt/
cd /mnt/
cp -av * /var/ftp/pub/

cp /mnt/images/pxeboot/vmlinuz /var/lib/tftpboot/networkboot/
cp /mnt/images/pxeboot/initrd.img /var/lib/tftpboot/networkboot/

umount /mnt/

```
# Step:5 Create kickStart & PXE menu file.
```
vi /var/ftp/pub/centos7.cfg
vi /var/lib/tftpboot/pxelinux.cfg/default
```
# Step:6 Start and enable xinetd, dhcp and vsftpd service.
```
systemctl start xinetd
systemctl enable xinetd
systemctl start dhcpd.service
systemctl enable dhcpd.service
systemctl start vsftpd
systemctl enable vsftpd

# SELinux
setsebool -P allow_ftpd_full_access 1

# Firewall rules

firewall-cmd --add-service=ftp --permanent
firewall-cmd --add-service=dhcp --permanent
firewall-cmd --add-port=69/tcp --permanent 
firewall-cmd --add-port=69/udp --permanent 
firewall-cmd --add-port=4011/udp --permanent
firewall-cmd --reload
```
# Step:7 Boot the clients with pxe boot option.

