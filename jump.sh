#!/bin/bash
####################################
#            setup
####################################
#
# as sudo, copy 'jump.sh' to '/bin/j' so you can run it by pressing 'j'.
#
# put "alias j='. j'" in .profile or wherever it will load on login
#  or else the 'cd' part won't work
#
####################################
#            usage
####################################
#
# press 'j' with no args to see a list of locations to jump to.
# press 'j <location>' to jump to that location.
# press 'j s' to save the current location so you can jump to it.
# edit '.jumps' in your home directory if you want to change/delete
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
    echo here are your saved locations:
    while read LINE; do
      printf "%-10s%s\n" "  ${LINE%% *}" "->  ${LINE##* }"
    done < $savefile
fi
