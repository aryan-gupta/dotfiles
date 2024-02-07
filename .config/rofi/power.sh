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
suspend=""
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
options="$shutdown\n$game\n$suspend\n$reboot"

# chosen="$(echo -e "$options" | $rofi_command -p "祥  $uptime  |     $cpu  |  ﬙  $memory " -dmenu -selected-row 2)"
chosen="$(echo -e "$options" | $rofi_command -p "$uptime" -dmenu -selected-row 1)"
case $chosen in
    $shutdown)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			#echo $(( $(head -1 /run/systemd/shutdown/scheduled |cut -c6-15) - $( date +%s ) ))
			systemctl poweroff
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        fi
        ;;

    $reboot)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			systemctl reboot
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        fi
        ;;

    $suspend)
		mpc -q pause
		systemctl suspend
        ;;

    $game)
        ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			sudo /usr/bin/restart_into_windows.sh
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        fi
        ;;
esac
