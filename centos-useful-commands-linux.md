# list of packages installed 

Ref https://www.2daygeek.com/check-installed-packages-in-rhel-centos-fedora-debian-ubuntu-opensuse-arch-linux/

```yum list installed```

---------------------------------------------------------------------
# list of ports 
Ref https://www.cyberciti.biz/faq/unix-linux-check-if-port-is-in-use-command/

```netstat -tulpn```
```
# Where ss command options are as follows:
#-t : Show only TCP sockets on Linux
#-u : Display only UDP sockets on Linux
#-l : Show listening sockets. For example, TCP port 22 is opened by SSHD server.
#-p : List process name that opened sockets
#-n : Don’t resolve service names i.e. don’t use DNS
```
----------------------------------------------------------------
# Check directory size 
ref https://www.tecmint.com/check-linux-disk-usage-of-files-and-directories/

```du -d 1 -h ```

# List of Services 

# https://www.cyberciti.biz/faq/check-running-services-in-rhel-redhat-fedora-centoslinux/

```service --status-all```
```systemctl list-unit-files```
