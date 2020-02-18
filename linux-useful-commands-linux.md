# list of packages installed 

Ref https://www.2daygeek.com/check-installed-packages-in-rhel-centos-fedora-debian-ubuntu-opensuse-arch-linux/

```yum list installed```

---------------------------------------------------------------------
# list of ports 

Ref https://www.cyberciti.biz/faq/unix-linux-check-if-port-is-in-use-command/

```netstat -tulpn```
```
#Where ss command options are as follows:
#-t : Show only TCP sockets on Linux
#-u : Display only UDP sockets on Linux
#-l : Show listening sockets. For example, TCP port 22 is opened by SSHD server.
#-p : List process name that opened sockets
#-n : Don’t resolve service names i.e. don’t use DNS
```
----------------------------------------------------------------


# List of Services 

Ref https://www.cyberciti.biz/faq/check-running-services-in-rhel-redhat-fedora-centoslinux/

```service --status-all```

```systemctl list-unit-files```
----------------------------------------------------------------

# List of sudo 

ref https://www.cyberciti.biz/faq/check-list-installed-packages-in-centos-linux/

```yum list installed Packages```

----------------------------------------------------------------

# Search and Replace
vi search(%s) text(/[1]/) and replcace[/[2] all the occurances(/g)

```:%s/searchedtext/replacetext/g```
----------------------------------------------------------------

# grep few lines after(-A) and before(-B)

ref  https://ma.ttias.be/grep-show-lines-before-and-after-the-match-in-linux/

```cat test.txt | grep -B 5 -A 5 'search text' ```
----------------------------------------------------------------
# get the size of directory

ref  https://ma.ttias.be/grep-show-lines-before-and-after-the-match-in-linux/
ref  https://www.tecmint.com/check-linux-disk-usage-of-files-and-directories/

```
du -d 1 -h # -d depth , -h human readable 
# to the directory size is more than certain MB(M)or GB (G) 
du -d 1 -h  <dir path>| grep '[0-9]G\>'
```
----------------------------------------------------------------
