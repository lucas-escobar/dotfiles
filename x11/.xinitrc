#!/bin/bash
xrandr --output DVI-D-0 --primary --left-of DP-2 --rate 144
feh --no-fehbg --bg-scale ~/wallpapers/nebula-1.png
redshift &

if [ -f /etc/X11/xinit/xinitrc ]; then
    . /etc/X11/xinit/xinitrc
fi
