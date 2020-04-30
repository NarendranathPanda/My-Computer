ref: https://www.linkedin.com/posts/narendranathpanda_ssh-setup-between-ansible-and-targetcd-activity-6601512931345698816-uIKd
ref: https://phoenixnap.com/kb/how-to-generate-ssh-key-centos-7
# Any node | user specific (i.e. root)
'''

ssh-keygen -t rsa

'''

# This will create three files at $HOME/.ssh/

'''

-rw-r--r--. 1 root root  386 Apr 30 11:58 known_hosts
-rw-r--r--. 1 root root  408 Apr 30 12:07 id_rsa.pub
-rw-------. 1 root root 1679 Apr 30 12:07 id_rsa

'''

# Two way to copy the public to the knownhost list of remote machine 
## Manually copy 
copy the id_rsa.pub to the end of the target machine's known_hosts file at the end . 



## ssh-copyid
ssh-copy-id <user>@<hostip>
