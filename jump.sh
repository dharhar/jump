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
# 'j f' to jump to a location picked by fuzzyfinder
# -b    to just print directory without using cd

savefile=~/.jumps
[ ! -f "$savefile" ] && touch $savefile

justprint=false
while getopts "b" opt; do
	case $opt in 
		b)
			justprint=true
			shift
	esac
done

#----- display locations -------

if [ $# -eq 0 ]; then
	echo Here are your saved locations:
	awk '{printf("%-10s%s\n",$1,"->  "$2)}' $savefile

#----- save locations ----------


elif [ "$1" = "s" ]; then

	isbuiltin(){
		[[ $newname =~ ^(s|e|f)$ ]] && echo The name $newname is used for a builtin command. && return 0
return 1
	}
	istaken(){
		nameclone=`egrep "^${newname}\s" $savefile` && echo -e "A location with this name already exists:\n\t${newname}  '->' ${nameclone##* }" && return 0
		return 1
	}
	checkname(){
		while istaken || isbuiltin; do
		badname=$newname
		echo Enter a new name:
		read newname
		[ "$newname" = "" ] && newname=$badname
		done
	}
	here=`pwd`
	if dirclone=`egrep "\s${here}$" $savefile`; then
		echo "This location is already saved as ${dirclone%% *}."
	else
		newname=`echo ${here##*/} | tr '[:upper:]' '[:lower:]'`
		checkname
	if [ "$badname" = "" ]; then
		echo press y to save as "'${newname}'" or enter new name.
		read choice
		[ ! "$choice" = "y" ] && newname=$choice
		checkname
	fi
		echo "$newname $here" >> $savefile
		echo -e "\t$newname  ->  $here\n\tsaved"
	fi


#----- edit locations --------------

elif [ "$1" = "e" ]; then
	${EDITOR-vi} $savefile

#----- go to location from fzf -----

elif [ "$1" = "f" ]; then
	cd `awk '{print $2}' $savefile | fzf`

#----- go to location from arg -----

else
while read LINE; do
	if [ "${LINE%% *}" = "$1" ]; then
		echo ${LINE##* }
		[ ! $justprint = true ] && cd ${LINE##* }
		break
	fi
	done < $savefile
fi
