#!/bin/bash

# Some explanation of what this script doing:
# It check's current monitors configuration using xrandr
# and then set next configuration state.
#
# 1 means on and 0 means off
# | internal | external |
# |     1    |     0    |
# |     0    |     1    |
# |     1    |     1    |
#
# When laptop lid is closed only external monitor is active
# When external monitor is disconnected only internal monitor is active

internal="eDP"
external="HDMI-A-0"

if [ -z "$internal" ] || [ -z "$external" ]; then
	notify-send "Screen info" "You must set monitor names"
	exit 1
fi

internal_active=$(xrandr | grep "$internal" -A 1 | grep "*")
external_active=$(xrandr --query | awk '/\<'"$external"'\>/ {print $2}')
# external_active=$(xrandr | grep "$external" -A 1 | grep "*")

external_only() {
	xrandr --output "$internal" --off --output "$external" --primary --auto
	sleep 1
	notify-send "Screen info" "$@"
}

internal_only() {
	xrandr --output "$external" --off --output "$internal" --auto --primary
	sleep 1
	notify-send "Screen info" "$@"
}

both_monitors() {
	# xrandr --output "$internal" --auto --output "$external" --primary --auto --right-of "$internal"
	xrandr --output "$internal" --primary --mode 1920x1080 --rotate normal --output "$external" --auto --rotate normal --right-of "$internal"
	sleep 1
	notify-send "Screen info" "Both monitors are active now."
}

if [ "$external_active" != "connected" ]; then
	internal_only "$external disconnected. Only $internal is active."

elif cat /proc/acpi/button/lid/LID0/state | grep "close"; then
	external_only "Laptop lid closed. Only $external is active now."

elif [ "$internal_active" ] && [ ! "$external_active" ]; then
	internal_only "Only $internal is active now monitor."

elif [ "$internal_active" ] && [ "$external_active" ]; then
	both_monitors

elif [ "$internal_active" ] && [ ! "$external_active" ]; then
	external_only "Only $external is active now."
fi
