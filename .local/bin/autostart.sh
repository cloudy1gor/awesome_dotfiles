#!/bin/bash

hours=$(date +%H)

# Check if the current hour is greater than or equal to 17 (5 PM) or less than 9 (9 AM)
if (( hours >= 17 || hours < 9 )); then
    restart=( "redshift" "-P" "-O" "4200" )
else 
    restart=( "redshift" "-P" "-O" "5000" )
fi

sh ~/.config/conky/startConky.sh &
declare -a apps=( "/usr/bin/dunst" "copyq" "megasync" "telegram-desktop" "safeeyes" "espanso service start --unmanaged" "glava" )

for app in "${apps[@]}"; do
    if [[ $(pidof "${app}") ]]; then
        pkill "${app}"
    fi
    sleep 0.1
    eval "${app}" &
done

# Check if the "redshift" command should be launched
if [[ ${#restart[@]} -gt 0 ]]; then
    pkill "redshift"
    sleep 0.1
    eval "${restart[*]}" &
fi

