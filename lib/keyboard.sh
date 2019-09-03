#! /bin/bash

# keyboard hacks

# make caps lock an additional backspace with repeat
setxkbmap -option caps:backspace
setxkbmap -option shift:both_capslock
xmodmap -e "clear Lock"
