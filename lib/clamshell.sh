#! /bin/bash
set -euo pipefail

# check if sway is bran new, if so give it some time to finish booting before
# yanking displays from under it
if [ $(ps -o etimes= -p $(pidof sway)) -lt 10 ]; then
    # TODO - figure out what we are actually waiting for and check that instead
    # of a random sleep
    echo "sway is just starting up, lets give her a few seconds to boot..."
    sleep 2
fi


state=enable
if [[ $(swaymsg -rt get_outputs | jq .[].make) =~ Goldstar|Dell ]]; then
    state=disable
fi
swaymsg output eDP-1 ${state}
# TODO - use the notify daemon.. when you get one
# swaynag -t warning -m "main display is ${state} - code ?"
