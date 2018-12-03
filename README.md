## Jump around your file system quicker than the cd command


## jump.sh:

**setup:**

 Put "alias j='. /path/to/jump.sh'" in .bashrc or else it will only 
 change the directory of the background shell, not your curent shell.

**usage:**

 Press 'j s' to save the current location so you can jump to it.

 Press 'j e' to edit the locations.

 Press 'j' with no args to see a list of locations to jump to.

 Press 'j \<location\>' to jump to that location.

---

## Copy files without typing directory paths


## cj:

**usage:**

 Press 'cj' with no args to see the current target directory for copying files to.

 Press 'cj s' to set the current directory as the target.

 Press 'cj \<files\>' to copy files to the target.

 Press 'cj j \<alias\> \<files\>' to copy files to the directory saved as \<alias\> by jump.sh.
