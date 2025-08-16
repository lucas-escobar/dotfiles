#!/usr/bin/env bash

polybar-msg cmd quit
while pgrep -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload example &
    done
else
    polybar --reload example &
fi

echo "Bars launched"
