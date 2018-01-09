**Shell script for jumping around your file system quicker than the cd command**

---

**setup:**

 Put "alias j='. /path/to/jump.sh'" in .bashrc or else it will only 
 change the directory of the background shell, not your curent shell.

**usage:**

 Press 'j s' to save the current location so you can jump to it.
 Press 'j' with no args to see a list of locations to jump to.
 Press 'j \<location\>' to jump to that location.
 Edit '.jumps' in your home directory if you want to change/delete
  your saved locations.
