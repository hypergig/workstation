#! /usr/bin/env bash

wmctrl -i -a $(wmctrl -lx | grep "gnome-terminal-server.Gnome-terminal" | sed -n ${@}p) || exec gnome-terminal.wrapper
