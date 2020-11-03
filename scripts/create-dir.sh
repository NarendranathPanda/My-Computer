#!bin/bash
myhome=$PWD
echo "HOME : "$myhome
printf "\n"


function start(){
while read url_path
do
 myHome;
 download $url_path
 printf "\n"
done < url_path.txt
printf "\n"
}

function download(){
 echo "Path : ${url_path}"
 IFS='/'
 read -a strarr <<<$url_path
 for val in "${strarr[@]}";
 do
  if [ "${val}" == "${strarr[@]: -1 }" ]
  then
    downloadFile $val;
  else
    createDir $val;
  fi
 done
}

function downloadFile(){
   echo "dir : $dir"
   mkdir -p "$dir"
   touch "$dir/$1"

}

function createDir(){
   dir=$dir/$1
   #mkdir $dir
}

function myHome(){
dir=$PWD
}

start
