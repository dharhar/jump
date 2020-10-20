#!/bin/bash
####################################
#            setup
####################################
#
# Put "alias j='. /path/to/jump.sh'" in .bashrc or else it will only 
# change the directory of the background shell, not your curent shell.
# Install fzf to use fzf mode.
#
####################################
#            usage
####################################
#
# 'j' with no args to see a list of locations to jump to.
# 'j <location>' to jump to that location.
# 'j s' to save the current location so you can jump to it.
# 'j e' to edit the saved locations
# 'j fzf' to jump to a location picked by fuzzyfinder

savefile=~/.jumps
[ ! -f "$savefile" ] && touch $savefile

#----- display locations -------

if [ $# -eq 0 ]; then
  echo Here are your saved locations:
  awk '{printf("%-10s%s\n",$1,"->  "$2)}' $savefile

#----- save locations ----------


elif [ "$1" = "s" ]; then

  checkname(){
    nameclone=`egrep "^${newname}\s" $savefile`
    while [ ! "$nameclone" = "" ]; do
      echo A location with this name already exists:
      echo ${newname}  '->' ${nameclone##* }
      echo Enter a new name:
      read newname
      nameclone=`egrep "^${newname}\s" $savefile`
    done
  }

  here=`pwd`
  saveit=true
  dirclone=`egrep "\s${here}$" $savefile`
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


#----- edit locations --------------

elif [ "$1" = "e" ]; then
  ${EDITOR-vi} $savefile

#----- go to location from fzf -----

elif [ "$1" = "fzf" ]; then
  cd `awk '{print $2}' $savefile | fzf`

#----- go to location from arg -----

else
while read LINE; do
  if [ "${LINE%% *}" = "$1" ]; then
    echo ${LINE##* }
    cd ${LINE##* }
    break
  fi
  done < $savefile
fi

unset savefile
unset here
unset saveit
unset dirclone
unset newname
unset nameclone
