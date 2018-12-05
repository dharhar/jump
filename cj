#!/bin/bash

sfile=~/.ctarget
jfile=~/sync/.jumps
touch $sfile $jfile


#-------show saved target--------------

if [ $# -eq 0 ]; then
  echo Copy target is `cat $sfile`

#-------save new target----------------

elif [ "$1" = "s" ]; then
  pwd > $sfile
  echo Ready to copy to `pwd`

#-------use target from jump file------

elif [ "$1" = "j" ]; then
  found=false
  dest=""
  while read LINE; do
    if [ "${LINE%% *}" = "$2" ]; then 
      dest=${LINE##* }
      found=true
    fi
  done < $jfile
  if [ $found = true ] && [ ! "$dest" = "" ]; then
    shift 2
    cp -ruv $@ ${dest}/
  else
    echo Could not find destination $2
  fi
  
#-------use saved target---------------

else
  dest=`cat $sfile`
  if [ ! "$dest" = "" ]; then 
    cp -ruv $@ `$dest`/
  else
    echo No target directory. use \'cj s\' to create one.
  fi

fi
