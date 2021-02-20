#!/usr/bin/env bash

rofi_command="rofi -theme sound $@"

uptime=$(uptime -p | sed -e 's/up //g')
cpu=$(sh ~/.config/rofi/usedcpu)
memory=$(sh ~/.config/rofi/usedram)

# Options
headphone="🎧"
computer="🖥️"
television="📺"

# Variable passed to rofi
options="$headphone\n$computer\n$television"
internal_sound_card="alsa_card.pci-0000_00_1b.0"
gpu_sound_card="alsa_card.pci-0000_03_00.1"

# chosen="$(echo -e "$options" | $rofi_command -p "祥  $uptime  |     $cpu  |  ﬙  $memory " -dmenu -selected-row 2)"
chosen="$(echo -e "$options" | $rofi_command -p "$uptime" -dmenu -selected-row 1)"
case $chosen in
    $headphone)
        pactl set-card-profile $gpu_sound_card      off
        pactl set-card-profile $internal_sound_card output:analog-stereo
        ;;
    $computer)
        pactl set-card-profile $gpu_sound_card      output:hdmi-stereo-extra4
        pactl set-card-profile $internal_sound_card off
        ;;
    $television)
        pactl set-card-profile $gpu_sound_card      output:hdmi-stereo
        pactl set-card-profile $internal_sound_card off
        ;;
esac
