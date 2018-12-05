#!/bin/bash
####################################
#            setup
####################################
#
# Put "alias j='. /path/to/jump.sh'" in .bashrc or else it will only 
# change the directory of the background shell, not your curent shell.
#
####################################
#            usage
####################################
#
# Press 'j' with no args to see a list of locations to jump to.
# Press 'j <location>' to jump to that location.
# Press 'j s' to save the current location so you can jump to it.
# Press 'j e' to edit the saved locations

savefile=~/.jumps
touch ${savefile}

#------display locations--------

if [ $# -eq 0 ]; then
  echo Here are your saved locations:
  awk '{printf("%-10s%s\n",$1,"->  "$2)}' $savefile

#------save locations-----------


elif [ "$1" = "s" ]; then

  checkname(){
    nameclone=`grep ^"${newname}\s" $savefile`
    while [ ! "$nameclone" = "" ]; do
      echo A location with this name already exists:
      echo ${newname}  '->' ${nameclone##* }
      echo Enter a new name:
      read newname
      nameclone=`grep ^"${newname}\s" $savefile`
    done
  }

  here=`pwd`
  saveit=true
  dirclone=`grep "\s${here}"$ $savefile`
  [ ! "$dirclone" = "" ] && echo "This location is already saved as ${dirclone%% *}." && saveit=false

  if [ "$saveit" = true ]; then
    newname=`echo ${here##*/} | tr '[:upper:]' '[:lower:]'`
    checkname
    echo press y to save as "'${newname}'" or enter new name.
    read choice
    [ ! "$choice" = "y" ] && newname=$choice
    checkname

    echo "$newname $here" >> $savefile
    echo -e "\t$newname  ->  $here\n\tsaved"
  fi


#------edit locations-----------

elif [ "$1" = "e" ]; then
  vi $savefile

#------go there ----------------

else
while read LINE; do
  if [ "${LINE%% *}" = "$1" ]; then
    echo ${LINE##* }
    cd ${LINE##* }
  fi
  done < $savefile
fi

unset savefile
unset here
unset saveit
unset dirclone
unset newname
unset nameclone
