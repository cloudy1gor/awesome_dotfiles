#!/bin/bash

if pgrep -x "conky" > /dev/null; then
  pkill -x conky
fi

conky -c $HOME/.config/conky/cal.conf -d &
conky -c $HOME/.config/conky/conky.conf -d &
