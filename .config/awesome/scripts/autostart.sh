#!/bin/bash

declare -a restart=( copyq megasync telegram-desktop safeeyes espanso )
for i in "${restart[@]}"; do
    if [[ `pidof $i` ]]; then
        pkill $i
    fi
    sleep 0.2
    eval "$i" &
done
