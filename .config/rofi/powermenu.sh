DIR="$HOME/.config/rofi"

rofi_command="rofi -theme $dir/powermenu.rasi"

uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown=""
reboot=""
lock=""
logout="󰍃"

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$logout"

chosen="$(echo "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
        sudo poweroff
        ;;
    $reboot)
        sudo reboot
        ;;
    $lock)
        ~/.local/bin/i3lock-fancy/i3lock-fancy.sh
        ;;
    $logout)
        bspc quit
        ;;
esac
