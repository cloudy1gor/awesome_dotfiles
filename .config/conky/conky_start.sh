#!/bin/bash

conky -q -c ~/.config/conky/conky_cal.conf -p ~/.config/conky/conky_cal.pid &
conky -q -c ~/.config/conky/conky.conf -p ~/.config/conky/conky.pid &
