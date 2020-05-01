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

#git add upstream 
git remote add <name> <url>
example
git remote add upstream https://github.com/grafana/grafana.git

# check the remotes 
git remote -v

#get remote repo content in local
git fetch upstream
git pull upstream master
```



# git pull request 
![git pull request](https://github.com/NarendranathPanda/my-configuration/blob/master/img/git.png)

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

ref : 
https://stackoverflow.com/questions/55249773/exporting-entire-git-configuration-to-be-used-with-git-config
https://www.slideshare.net/JonathanFrappier/introduction-to-github-new-england-vtug-winter-warmer?from_action=save



```shell
git config --global --list
user.name=Narendranath Panda
user.email=panda.narendranath@gmil.com
http.lowspeedlimit=1000
http.lowspeedtime=600
http.postbuffer=100000000
core.protectntfs=false
core.editor='C:\Program Files (x86)\Notepad++\notepad++.exe' -multiInst -notabbar -nosession -noPlugin
filter.lfs.process=git-lfs filter-process
filter.lfs.required=true
filter.lfs.clean=git-lfs clean -- %f
filter.lfs.smudge=git-lfs smudge -- %f
https.proxy=<proxy url>
```
