# jump
Shell script for jumping around your file system quicker than the cd command

####################################
            setup
####################################

As sudo, copy 'jump.sh' to '/bin/j' so you can run it by pressing 'j'.

Put "alias j='. j'" in .profile or wherever it will load on login
 or else the 'cd' part won't work.

####################################
            usage
####################################

 Press 'j' with no args to see a list of locations to jump to.
 Press 'j <location>' to jump to that location.
 Press 'j s' to save the current location so you can jump to it.
 Edit '.jumps' in your home directory if you want to change/delete
  your saved locations.
