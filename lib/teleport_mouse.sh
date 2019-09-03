#! /bin/bash

set -e

window=$(xdotool getactivewindow)

xdotool mousemove --polar -w $window 0 0
notify-send -i mouse "Mouse Teleporter" "Teleported to $(xdotool getwindowname $window)"
