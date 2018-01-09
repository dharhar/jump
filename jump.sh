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
# Edit '.jumps' in your home directory if you want to change/delete
#  your saved locations.

savefile=~/.jumps

#------initial setup------------
if [ ! -f ${savefile} ]
  then
    touch ${savefile}
fi
#------save locations-----------

if [ "$1" = "s" ]
  then
    here=`pwd`
    saveit=true
    namefree=true
    newname=`echo ${here##*/} | tr '[:upper:]' '[:lower:]'`

    while read LINE; do
      if [ "$here" = "${LINE##* }" ] 
        then
          echo this location is already saved as ${LINE%% *}
          saveit=false
          break
      fi
      if [ "${LINE%% *}" = "${newname}" ] 
        then
          namefree=false
          echo a location with this name already exists:
          echo ${newname} '->' ${LINE##* }
      fi
      done < $savefile

    if $saveit
      then
        if $namefree
          then
            echo "press y to save as '"${newname}"' or enter new name."
            read choice
            if [ $choice = 'y' ]
              then
                echo "$newname $here" >> $savefile
                echo $newname    '->'    $here
            else
                echo "$choice $here" >> $savefile
                echo $choice    '->'    $here
            fi
        else
          echo enter a name to save this location as: 
          read choice
          echo "$choice $here" >> $savefile
        fi
        echo saved

    fi

#------go there ----------------

else
while read LINE; do
  if [ "${LINE%% *}" = "$1" ] 
    then
      echo ${LINE##* }
      cd ${LINE##* }
  fi
  done < $savefile
fi

#------display locations--------
if [ $# -eq 0 ]
  then
#uncomment if you want to use less
#    savedlocations=$(mktemp)
    echo here are your saved locations:
    while read LINE; do
      printf "%-10s%s\n" "  ${LINE%% *}" "->  ${LINE##* }" # >> savedlocations
    done < $savefile
#    less savedlocations
#    rm savedlocations
  fi
