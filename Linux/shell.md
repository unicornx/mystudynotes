[How to grep a specific line _and_ the first line of a file?](http://unix.stackexchange.com/questions/47918/how-to-grep-a-specific-line-and-the-first-line-of-a-file)
ps xj | awk 'NR == 1 || /pts\/1/'