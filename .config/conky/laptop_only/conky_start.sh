#!/bin/bash

if pgrep -x "conky" >/dev/null; then
	pkill -x conky
fi

conky -q -c ~/.config/conky/conky_cal.conf -p ~/.config/conky/conky_cal.pid &
sleep 0.3
conky -q -c ~/.config/conky/conky.conf -p ~/.config/conky/conky.pid &
