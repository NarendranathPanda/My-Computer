#!bin/bash
myhome=$PWD
echo "HOME : "$myhome
printf "\n"

file=$PWD/url_path.txt
URL=https://download.aiporeto.com/releases/releases-$1
HOME=$1
rm -rf $HOME
mkdir $HOME
function main(){
 IFS='|'
 while read -r dir file
 do
  if [ -z $dir ]
  then
   printf "%s\n" $HOME/$file
   echo "wget -O $HOME/$file $URL/$file" > $HOME/$file
  else
   printf "%s\n" $HOME/$dir
   mkdir -p $HOME/$dir
   printf "\t%s\n" $file
   echo "wget -O $HOME/$dir/$file $URL/$dir/$file">$HOME/$dir/$file

  fi
 done <"$file"
printf "\n"
}

main
