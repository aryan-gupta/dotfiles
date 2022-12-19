#!/usr/bin/env bash

# This script is largly based off of
# https://github.com/adi1090x/rofi
# ./1080p/applets/menu/powermenu.sh
# commit b4021ff

rofi_command="rofi -theme power $@"

uptime=$(uptime -p | sed -e 's/up //g')
# cpu=$(sh ~/.config/rofi/usedcpu)
# memory=$(sh ~/.config/rofi/usedram)

# Options
shutdown=""
reboot=""
lock=""
suspend=""
logout=""
game=""

# Confirmation
confirm_exit() {
	rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "Are You Sure? : "\
		-theme confirm
}

# Message
msg() {
	rofi -theme message -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$game\n$suspend\n$logout"

# chosen="$(echo -e "$options" | $rofi_command -p "祥  $uptime  |     $cpu  |  ﬙  $memory " -dmenu -selected-row 2)"
chosen="$(echo -e "$options" | $rofi_command -p "$uptime" -dmenu -selected-row 3)"
case $chosen in
    $shutdown)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			#echo $(( $(head -1 /run/systemd/shutdown/scheduled |cut -c6-15) - $( date +%s ) ))
			systemctl poweroff
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $reboot)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			systemctl reboot
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $lock)
        betterlockscreen -l blur
        ;;
    $suspend)
		mpc -q pause
		systemctl suspend
        ;;
    $logout)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
				openbox --exit
			elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
				bspc quit
			elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
				i3-msg exit
			fi
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;

    $game)
        ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			sudo /usr/bin/restart_into_windows
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
esac
