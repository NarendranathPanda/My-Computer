# How to check os version in Linux command line
Open the terminal application (bash shell)

For remote server login using the ssh: ssh user@server-name

Type any one of the following command to find os name and version in Linux:
```
cat /etc/os-release
lsb_release -a
hostnamectl
cat /etc/redhat-release
```
Type the following command to find Linux kernel version:
```
uname -r
```
-----------------------------------------------------------

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

```
service --status-all

systemctl list-unit-files
```
----------------------------------------------

# Add user with same group and username 

Ref https://linux.die.net/man/8/useradd

```
sudo useradd -Urs /bin/false username
```
----------------------------------------------------------------

# List of packages

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

# memory usage

ref 

```
free -m
```
----------------------------------------------------------------
# cpu details

ref 

```
nproc
```
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

# List of Users

ref : https://www.liquidweb.com/kb/list-users-centos-7/

```cut -d: -f1 /etc/passwd```

-----------------------------------------------------------------


# Redirect All Output to /dev/null

ref : https://www.maketecheasier.com/dev-null-in-linux/

```<command> >/dev/null 2>&1```

The string >/dev/null means “send stdout to /dev/null,” and the second part, 2>&1, means send stderr to stdout. In this case you have to refer to stdout as “&1” instead of simply “1.” Writing “2>1” would just redirect stdout to a file named “1.”

-----------------------------------------------------------------

# writing to file without cat EOF
ref : https://linuxize.com/post/create-a-file-in-linux/#creating-a-file-with-cat-command

```
cat >>file-path<<EOF
content
EOF
```
## example
```cat >>/etc/hosts<<EOF
172.42.42.100 kmaster.example.com kmaster
172.42.42.101 kworker1.example.com kworker1
172.42.42.102 kworker2.example.com kworker2
EOF
```

# writing to file with echo 

echo "Some line" > file1.txt

# writing multiple lines to a file with cat 

```
cat > file1.txt
```

The cat command is mainly used to read and concatenate files, but it can also be used for creating new files.

To create a new file run the cat command followed by the redirection operator > and the name of the file you want to create. Press Enter type the text and once you are done press the CRTL+D to save the files.

-----------------------------------------------------------------
# create a user and allow it to be sudo

ref : https://www.digitalocean.com/community/tutorials/initial-server-setup-with-centos-7

This example creates a new user called “demo”, but you should replace it with a user name that you like:

```shell

#create user
adduser demo
```
Next, assign a password to the new user (again, substitute “demo” with the user that you just created):
```
#set it's password 
passwd demo
```
As root, run this command to add your new user to the wheel group (substitute the highlighted word with your new user):

```
# add it to the wheel group ,hence it can be used sudo
gpasswd -a demo wheel

```
-----------------------------------------------------------------
