#!/bin/bash

sfile=~/.ctarget
jfile=~/sync/.jumps
touch $sfile $jfile
dest=`cat $sfile`
found=false


#-------show saved target--------------

if [ $# -eq 0 ]; then
  echo copy target is `cat $sfile`

#-------save new target----------------

elif [ "$1" = "s" ]; then
  pwd > $sfile
  echo ready to copy to `pwd`

#-------use target from jump file------

elif [ "$1" = "j" ]; then
  while read LINE; do
    if [ "${LINE%% *}" = "$2" ]; then 
      dest=${LINE##* }
      found=true
    fi
  done < $jfile
  if [ $found = true ]; then
    shift 2
    cp -ruv $@ ${dest}/
  else
    echo could not find destination $2
  fi
  
#-------use saved target---------------

else
  cp -ruv $@ `cat $sfile`/

fi
