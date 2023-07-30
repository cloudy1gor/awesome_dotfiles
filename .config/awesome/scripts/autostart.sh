#!/bin/bash

# Notifications
if [[ `pidof dunst` ]]; then
    pkill dunst
fi
/usr/bin/dunst &

hours=$(date +%H)

declare -a restart=("copyq" "megasync" "telegram-desktop" "safeeyes" "espanso")

# Check if the current hour
if (( hours > 17 && $hours < 7 )); then
    restart+=("redshift")
fi

for i in "${restart[@]}"; do
    if [[ `pidof $i` ]]; then
        pkill $i
    fi
    sleep 0.2
    eval "$i" &
done

