# GIT  configuration 
## Setup when you are behind the corporate firewall
ref : https://github.com/w3c/epubcheck/issues/771#issuecomment-309230445
The right way to go is using https than should be enable by your firewall. However, you need to declare the proxy corporate to git. 

Depending on whether you need to authenticate or not you should add this information to the global configuration of git :

```
git config --global http.proxy http://proxyuser:proxypwd@proxy.server.com:8080
```
or
```
git config --global http.proxy http://proxy.server.com:8080
```
Then the command
```
git clone https://github.com/WSchindler/epubcheck.git
```
should work


## Command 
```shell
git init <directory name>
git add -A 
git commit -m "<message>"

#Create new branch from the existing branch
git branch <branch name>

#bring to workingset <branch name > if exist ok , else create new one
git checkout -b <branch name >

#Forward the changes to remote repo
git push
git push -u origin <new branch name>

#list of configs   
git config --list

#command line merge in case of conflict check 
git mergetool  

#get the remote changes and merged 
git pull origin <branch name> 

#park the current changes and make the workingset clean
git stash

#Apply the latest change to the workingset 
git stash apply 

```

# Reference 
### Learn git 
https://www.javatpoint.com/git

### Git Workflow: 
![Git WorkFlow](https://images.osteele.com/2008/git-transport.png)

https://blog.osteele.com/2008/05/my-git-workflow/

### Authentication failed without prompt for user name and password
https://github.com/Microsoft/Git-Credential-Manager-for-Windows/issues/141#issuecomment-199408564

### Git 2.24 breaks existing repositories: filename in tree entry contains backslash
https://stackoverflow.com/questions/59345571/pycharm-behaving-strange-with-git-filename-in-tree-entry-contains-backslash

### 1.6 Getting Started - First-Time Git Setup
https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup

### What is Origin 
![Git Origin](https://static.javatpoint.com/tutorial/git/images/git-origin-master2.png)

https://www.javatpoint.com/git-origin-master




```shell
$ git config --list --show-origin
file:C:/Program Files/Git/etc/gitconfig http.sslcainfo=C:/Program Files/Git/mingw64/ssl/certs/ca-bundle.crt
file:C:/Program Files/Git/etc/gitconfig http.sslbackend=openssl
file:C:/Program Files/Git/etc/gitconfig diff.astextplain.textconv=astextplain
file:C:/Program Files/Git/etc/gitconfig filter.lfs.clean=git-lfs clean -- %f
file:C:/Program Files/Git/etc/gitconfig filter.lfs.smudge=git-lfs smudge -- %f
file:C:/Program Files/Git/etc/gitconfig filter.lfs.process=git-lfs filter-process
file:C:/Program Files/Git/etc/gitconfig filter.lfs.required=true
file:C:/Program Files/Git/etc/gitconfig core.autocrlf=true
file:C:/Program Files/Git/etc/gitconfig core.fscache=true
file:C:/Program Files/Git/etc/gitconfig core.symlinks=false
file:C:/Program Files/Git/etc/gitconfig core.longpaths=true
file:C:/Program Files/Git/etc/gitconfig credential.helper=manager
file:C:/Users/npanda/.gitconfig user.name=Narendranath Panda
file:C:/Users/npanda/.gitconfig user.email=narendranath.panda@nokia.com
file:C:/Users/npanda/.gitconfig http.lowspeedlimit=1000
file:C:/Users/npanda/.gitconfig http.lowspeedtime=600
file:C:/Users/npanda/.gitconfig http.postbuffer=100000000
file:C:/Users/npanda/.gitconfig core.protectntfs=false
file:C:/Users/npanda/.gitconfig core.editor='C:\Program Files (x86)\Notepad++\notepad++.exe' -multiInst -notabbar -nosession -noPlugin
file:.git/config        core.repositoryformatversion=0
file:.git/config        core.filemode=false
file:.git/config        core.bare=false
file:.git/config        core.logallrefupdates=true
file:.git/config        core.symlinks=false
file:.git/config        core.ignorecase=true
```



