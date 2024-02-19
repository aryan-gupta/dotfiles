#! /bin/sh
# set -x

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
HOSTNAME=$(hostname)

export NO_AT_BRIDGE=1
export HOSTNAME=$HOSTNAME

# ======================== colors =======================
# background is flat shade of black
export COLOR_BACKGND_N='#1A1A1A'
export COLOR_BACKGND_L=''
export COLOR_BACKGND_D=''

# foreground is shade of white
export COLOR_FOREGND_N='#F5F5F5'
export COLOR_FOREGND_L=''
export COLOR_FOREGND_D=''

# seconday is light accent color
export COLOR_ACNTLGT_N='#F4D35E'
export COLOR_ACNTLGT_L=''
export COLOR_ACNTLGT_D=''

# primary is dark accent color
export COLOR_ACNTDRK_N='#391C5F';
export COLOR_ACNTDRK_L='#703C90';
export COLOR_ACNTDRK_D='#1C0E2F';

# warnings are alert colors (green, yellow, red)
export COLOR_WARNING_H='#d24d57';
export COLOR_WARNING_M='#F1F514';
export COLOR_WARNING_L='#CAFFD0';

# https://unix.stackexchange.com/questions/14129/
export GTK_THEME='Adwaita:dark';
# ======================== colors =======================

# ========================= Xorg ========================
# merge in defaults and keymaps
if [ -f $sysresources ]; then
  xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
  xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
  xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Disable CapsLock
#setxkbmap -option ctrl:nocaps
setxkbmap -option caps:super
xsetroot -cursor_name left_ptr &
# ========================= Xorg ========================

# ======================== displays ========================
case $HOSTNAME in
  ("boson")
    export PRIMARY_MONITOR='eDP-1'
    xrandr --output $PRIMARY_MONITOR --primary --mode 1920x1200 --pos 0x0 --rotate normal
      #--output DisplayPort-1 --off \
      #--output DisplayPort-2 --off \
      #--output HDMI-A-0 --off # --mode 1920x1080 --pos 0x0 --rotate normal

    # xrandr --output eDP-1 --primary --mode 1920x1200 --pos 2560x240 --rotate normal --output HDMI-1 --mode 2560x1440 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-2 --off --output DP-2 --off --output HDMI-3 --off --output DP-3 --off --output DP-4 --off
  ;;

  ("graviton")
    xrandr=$(xrandr)

    $(echo $xrandr | grep "DisplayPort-0 connected" -q) && export PRIMARY_MONITOR='DisplayPort-0'
    $(echo $xrandr | grep "DisplayPort-1 connected" -q) && export   RIGHT_MONITOR='DisplayPort-1'
    $(echo $xrandr | grep "DisplayPort-2 connected" -q) && export    LEFT_MONITOR='DisplayPort-2'
    $(echo $xrandr | grep      "HDMI-A-0 connected" -q) && export  TABLET_MONITOR='HDMI-A-0'

    xrandr_cmd="xrandr "

    [ $PRIMARY_MONITOR ] && xrandr_cmd="$xrandr_cmd"" --output $PRIMARY_MONITOR --primary --mode 3840x1600 --pos 1080x0    --rotate normal "
    [ $LEFT_MONITOR    ] && xrandr_cmd="$xrandr_cmd"" --output $LEFT_MONITOR              --mode 1920x1080 --pos 0x0       --rotate left   "
    [ $RIGHT_MONITOR   ] && xrandr_cmd="$xrandr_cmd"" --output $RIGHT_MONITOR             --mode 1920x1080 --pos 4920x0    --rotate left   "
    [ $TABLET_MONITOR  ] && xrandr_cmd="$xrandr_cmd"" --output $TABLET_MONITOR            --mode 1920x1080 --pos 2040x1920 --rotate normal "

    # echo $xrandr_cmd
    eval $xrandr_cmd
  ;;

  (*)
  ;;
esac
# ======================== displays ========================
feh --no-fehbg --bg-fill ~/.config/wallpaper.jpg &

# ======================== apps ========================
case $HOSTNAME in
  ("boson")
    killall -q libinput-gestures-setup && libinput-gestures-setup start &
    xinput set-prop 'ELAN0672:00 04F3:3187 Touchpad' 'libinput Natural Scrolling Enabled'      1
    xinput set-prop 'ELAN0672:00 04F3:3187 Touchpad' 'libinput Tapping Enabled'                1
    xinput set-prop 'ELAN0672:00 04F3:3187 Touchpad' 'libinput Tapping Drag Lock Enabled'      1
    xinput set-prop 'ELAN0672:00 04F3:3187 Touchpad' 'libinput Tapping Button Mapping Enabled' 0 1
    xinput set-prop 'Logitech Wireless Mouse'        'libinput Accel Speed'                    -0.9
    export BROWSER="firefox"
  ;;

  ("graviton")
    # [ ! -s ~/.config/mpd/pid ] && mpd
    export BROWSER="firefox"
    export VPNBROWSER="brave"
  ;;

  (*)
  ;;
esac

killall -q picom     ; picom &
killall -q redshift  ; redshift -P -O 3500 &
killall -q dunst     ; dunst &
killall -q flameshot ; flameshot &
killall -q unclutter ; unclutter --timeout 2 --jitter 5 --exclude-root --ignore-scrolling --fork
# ======================== apps ========================

# ======================== handoff ========================
exec /bin/bspwm
# ======================== handoff ========================
