#!/bin/bash

hours=$(date +%H)

declare -a restart=("copyq" "megasync" "telegram-desktop" "safeeyes" "espanso")

# Check if the current hour is less than 17 (5 PM)
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

