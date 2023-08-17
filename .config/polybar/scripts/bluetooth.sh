#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
  echo "%{F#ffffff}󰂱 OFF"
else
  if [ $(echo info | bluetoothctl | grep 'Device' | wc -c) -eq 0 ]
  then 
    echo "󰂱 OK"
  fi
  echo "%{F#88c7dc}󰂱 ON"
fi

