#!/bin/bash

if [ "$(xset -q | grep "Caps Lock" | awk '{print $4}')" = "on" ]; then
  echo "󰪛 " # Caps Lock is on
else
  echo "󰌌 " # Caps Lock is off
fi
