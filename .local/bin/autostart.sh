#!/bin/bash

# Get the current hour
hours=$(date +%H)

# Check if the current hour is greater than or equal to 17 (5 PM) or less than 9 (9 AM)
if ((hours >= 17 || hours < 9)); then
    restart=("redshift" "-P" "-O" "4000")
else
    restart=("redshift" "-P" "-O" "4700")
fi

# Start or restart redshift
if [[ ${#restart[@]} -gt 0 ]]; then
    pkill "redshift"
    sleep 0.1
    "${restart[@]}" &
fi

# List of apps to start
declare -a apps=(
    "bash ~/.config/conky/conky_start.sh"
    "/usr/bin/dunst"
    "copyq"
    "megasync"
    "telegram-desktop -startintray"
    "safeeyes --no-start"
    "espanso service start --unmanaged"
    "glava"
)

# Start or restart apps
for app in "${apps[@]}"; do
    exe_name=$(echo "$app" | awk '{print $1}')
    if pidof "$exe_name" > /dev/null; then
        pkill "$exe_name"
    fi

    sleep 0.1
    eval "$app" &
done

