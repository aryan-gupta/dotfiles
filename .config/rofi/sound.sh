#!/usr/bin/env bash

rofi_command="rofi -theme sound $@"

uptime=$(uptime -p | sed -e 's/up //g')
cpu=$(sh ~/.config/rofi/usedcpu)
memory=$(sh ~/.config/rofi/usedram)

# Options
headphone="🎧"
computer="🖥️"

# Variable passed to rofi
options="$headphone\n$computer"

# card names and profiles can be viewed by: pactl list cards
internal_sound_card="alsa_card.pci-0000_09_00.4"
gpu_sound_card="alsa_card.pci-0000_07_00.1"
gpu_sound_card_sink="alsa_output.pci-0000_07_00.1.hdmi-stereo-extra4"
external_dac="alsa_card.usb-Schiit_Audio_Schiit_Modi_3E-00"
external_dac_sink="alsa_output.usb-Schiit_Audio_Schiit_Modi_3E-00.pro-output-0"

# chosen="$(echo -e "$options" | $rofi_command -p "祥  $uptime  |     $cpu  |  ﬙  $memory " -dmenu -selected-row 2)"
chosen="$(echo -e "$options" | $rofi_command -p "$uptime" -dmenu -selected-row 0)"
sink=""
case $chosen in
    $headphone)
        pactl set-card-profile $external_dac        pro-audio
        pactl set-card-profile $gpu_sound_card      off
        pactl set-card-profile $internal_sound_card off
        $sink=$external_dac_sink
        ;;
    $computer)
        pactl set-card-profile $external_dac        off
        pactl set-card-profile $gpu_sound_card      output:hdmi-stereo-extra4
        pactl set-card-profile $internal_sound_card off
        $sink=$gpu_sound_card_sink
        ;;
esac

pactl list short sink-inputs|while read stream; do
    id=$(echo $stream|cut '-d ' -f1)
    echo "moving stream $id"
    pactl move-sink-input "$id" "$sink"
done