#!/bin/bash

sfile=~/.ctarget
touch $sfile

if [ $# -eq 0 ]; then
  echo copy target is `cat $sfile`

elif [ "$1" = "s" ]; then
  pwd > $sfile
  echo ready to copy to `pwd`

else
  cp -ruv $@ `cat $sfile`

fi
