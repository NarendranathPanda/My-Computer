# Follow the following procedure to git rid of big size files from the repo (including the history)
ref : https://gitlabe2.ext.net.nokia.com/help/user/project/repository/reducing_the_repo_size_using_git.md

## get BFG file 
```
sudo su
cd /tmp 
wget https://repo1.maven.org/maven2/com/madgag/bfg/1.13.0/bfg-1.13.0.jar
mv bfg-1.13.0.jar bfg.jar
```

## Set the alias 
```alias bfg=java -jar /tmp/bfg.jar```

## Remove the file from git 
```
cd my_repository/
git checkout master
git rm path/to/big_file.mpg
git commit -m 'Remove unneeded large file'
```

# Run the bfg to rewrite the history 
```cd my_repository/```
```bfg --delete-files "file_name" ```
or 
```bfg --delete-files "file_name"```

```git reflog expire --expire=now --all && git gc --prune=now --aggressive```

## Finaly push the changes (check for the protected tag : https://gitlabe2.ext.net.nokia.com/help/user/project/protected_tags )
```git push --force-with-lease origin master```
