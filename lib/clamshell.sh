#! /bin/bash

state=enable
if [[ $(swaymsg -t get_outputs) =~ Dell ]]; then
    state=disable
fi
swaymsg output eDP-1 ${state}
# TODO - use the notify daemon.. when you get one
# swaynag -t warning -m "main display is ${state} - code ?"
