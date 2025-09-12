#!/bin/bash

internal="eDP"
external="HDMI-A-0"
primary="DisplayPort-0"

if [ -z "$internal" ] || [ -z "$external" ]; then
    notify-send "Screen info" "You must set monitor names"
    exit 1
fi

# Проверка состояния мониторов
internal_active=$(xrandr | grep "^$internal connected")
external_status=$(xrandr | awk '/^'"$external"' / {print $2}')

# Функции
external_only() {
    xrandr --output "$internal" --off \
           --output "$primary" --primary --mode 2560x1440 --pos 0x0 --rotate normal \
           --output "$external" --mode 1920x1080 --pos 2560x0 --rotate right
    sleep 1
    notify-send "Screen info" "$@"
}

internal_only() {
    xrandr --output "$external" --off \
           --output "$primary" --off \
           --output "$internal" --auto --primary
    sleep 1
    notify-send "Screen info" "$@"
}

both_monitors() {
    xrandr --output "$internal" --primary --mode 1920x1080 --rotate normal \
           --output "$external" --mode 1920x1080 --rotate normal --right-of "$internal" \
           --output "$primary" --mode 2560x1440 --pos 0x0 --rotate normal
    sleep 1
    notify-send "Screen info" "Both monitors are active now."
}

# Основная логика
if [ "$external_status" != "connected" ]; then
    internal_only "External monitor disconnected. Only $internal is active."

elif grep -q "closed" /proc/acpi/button/lid/LID0/state; then
    external_only "Laptop lid closed. Only $external is active now."

elif [ -n "$internal_active" ] && [ "$external_status" = "connected" ]; then
    both_monitors

else
    internal_only "Only $internal is active now."
fi
