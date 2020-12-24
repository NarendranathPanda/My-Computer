Ref : https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
      https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-centos-7
      




1. Update your centos7 

    $ sudo yum update -y

2. Add the epel release repo

    $ sudo yum install epel-release -y
    
3. Install python3 

    $ sudo yum install python3 -y 
    
4. Install ansible 

    $ pip3 install ansible --user
    
5. Add the ansible binary to the PATH

    $ sudo echo "export PATH=$PATH:$HOME/.local/bin" >> ~/.bashrc 
    
6. Add your public key to authorized keys file 

Ref : add ssh keys https://phoenixnap.com/kb/how-to-generate-ssh-key-centos-7

7. Check the following command 

    $ sudo ansible localhost -m ping
