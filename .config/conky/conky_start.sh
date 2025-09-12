#!/bin/bash

# Kill existing conky processes
if pgrep -x "conky" >/dev/null; then
    pkill -x "conky"
fi

# Require xrandr
if ! command -v xrandr >/dev/null 2>&1; then
    echo "xrandr не найден — невозможно определить разрешение. Убедитесь, что вы в X11 и xrandr установлен."
    exit 1
fi

# Get the largest active resolution from xrandr (handles multi-monitor)
RESOLUTION=$(xrandr | grep '\*' | awk '{print $1}' | sort -V | tail -n1)

# Fallback: try xdpyinfo if nothing found
if [ -z "$RESOLUTION" ] && command -v xdpyinfo >/dev/null 2>&1; then
    RESOLUTION=$(xdpyinfo | awk '/dimensions:/ {print $2}')
fi

# Final fallback
if [ -z "$RESOLUTION" ]; then
    echo "Не удалось определить разрешение — ставлю по умолчанию 1920x1080"
    RESOLUTION="1920x1080"
fi

# Extract width (robustly)
WIDTH=${RESOLUTION%x*}   # faster than cut; works if RESOLUTION like 1920x1080

echo "Detected resolution: $RESOLUTION (width: $WIDTH)"

# Define config directory
CONFIG_DIR="$HOME/.config/conky"

# Choose configs
if [ "$WIDTH" -ge 2000 ]; then
    echo "Detected high resolution monitor ($RESOLUTION), using 2K configs"
    MAIN_CONFIG="$CONFIG_DIR/conky.conf"
    CAL_CONFIG="$CONFIG_DIR/conky_cal.conf"
else
    echo "Detected laptop / FHD ($RESOLUTION), using laptop configs"
    MAIN_CONFIG="$CONFIG_DIR/conky_fhd.conf"
    CAL_CONFIG="$CONFIG_DIR/conky_cal.conf"
fi

# Fallbacks if files missing
if [ ! -f "$MAIN_CONFIG" ]; then
    echo "Main config $MAIN_CONFIG not found; trying $CONFIG_DIR/conky.conf"
    if [ -f "$CONFIG_DIR/conky.conf" ]; then
        MAIN_CONFIG="$CONFIG_DIR/conky.conf"
    else
        echo "No main conky configuration found; abort."
        exit 1
    fi
fi

if [ ! -f "$CAL_CONFIG" ]; then
    echo "Calendar config $CAL_CONFIG not found; skipping calendar."
    CAL_CONFIG=""
fi

# Start conky instances
if [ -n "$CAL_CONFIG" ]; then
    echo "Starting calendar conky with: $CAL_CONFIG"
    conky -q -c "$CAL_CONFIG" -p "$CONFIG_DIR/conky_cal.pid" &
    sleep 0.3
fi

echo "Starting main conky with: $MAIN_CONFIG"
conky -q -c "$MAIN_CONFIG" -p "$CONFIG_DIR/conky.pid" &

