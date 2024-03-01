#! /bin/sh
# set -x

export ROOT_FS_TEXT="%{F$COLOR_ACNTLGT_N}root%{F-}%{F$COLOR_ACNTDRK_L}:%{F-} %percentage_used:2%% "
export HOME_FS_TEXT="%{F$COLOR_ACNTLGT_N}data%{F-}%{F$COLOR_ACNTDRK_L}:%{F-} %percentage_used:2%% "
export NAS_FS_TEXT="%{F$COLOR_ACNTLGT_N}nas%{F-}%{F$COLOR_ACNTDRK_L}:%{F-} %percentage_used:2%% "
export ROOT_FS_TEXT_ERR="%{F$COLOR_ACNTLGT_N}root%{F-}%{F$COLOR_ACNTDRK_L}:%{F-} %{F$COLOR_WARNING_H}!mnt%{F-} "
export HOME_FS_TEXT_ERR="%{F$COLOR_ACNTLGT_N}data%{F-}%{F$COLOR_ACNTDRK_L}:%{F-} %{F$COLOR_WARNING_H}!mnt%{F-} "
export NAS_FS_TEXT_ERR="%{F$COLOR_ACNTLGT_N}nas%{F-}%{F$COLOR_ACNTDRK_L}:%{F-} %{F$COLOR_WARNING_H}!mnt%{F-} "
export TEMP_TEXT="%{F$COLOR_ACNTLGT_N}temp%{F-}%{F$COLOR_ACNTDRK_L}:%{F-} %temperature-c% "
export CPU_TEXT="%{F$COLOR_ACNTLGT_N}cpu%{F-}%{F$COLOR_ACNTDRK_L}:%{F-} %percentage-sum:3% "
export MEM_TEXT="%{F$COLOR_ACNTLGT_N}mem%{F-}%{F$COLOR_ACNTDRK_L}:%{F-} %percentage_used:2%% "
export VOL_TEXT="%{F$COLOR_ACNTLGT_N}vol%{F-}%{F$COLOR_ACNTDRK_L}:%{F-}%percentage:3%% "
export VOM_TEXT="%{F$COLOR_ACNTLGT_N}vol%{F-}%{F$COLOR_ACNTDRK_L}:%{F-} %{F$COLOR_WARNING_H}mut%{F-} "
export BL_TEXT="%{F$COLOR_ACNTLGT_N}blite%{F-}%{F$COLOR_ACNTDRK_L}:%{F-}%percentage:3%% "
export BATT_C_TEXT="%{F$COLOR_ACNTLGT_N}batt%{F-}%{F$COLOR_ACNTDRK_L}:%{F-} %percentage:2%% "
export BATT_D_TEXT="%{F$COLOR_ACNTLGT_N}batt%{F-}%{F$COLOR_ACNTDRK_L}:%{F-} %percentage:2%% "
export BATT_F_TEXT="%{F$COLOR_ACNTLGT_N}batt%{F-}%{F$COLOR_ACNTDRK_L}:%{F-} %{F$COLOR_WARNING_L}ful%{F-} "
export BATT_E_TEXT="%{F$COLOR_ACNTLGT_N}batt%{F-}%{F$COLOR_ACNTDRK_L}:%{F-} %{F$COLOR_WARNING_H}low%{F-} "
export MUSIC_TEXT="%title%%{F$COLOR_ACNTDRK_L} - %{F-}%{F$COLOR_ACNTLGT_N}%artist%%{F-}"
export DATE_TEXT="%Y%{F$COLOR_ACNTDRK_L}-%{F-}%m%{F$COLOR_ACNTDRK_L}-%{F-}%d"
export TIME_TEXT="%H%{F$COLOR_ACNTDRK_L}:%{F-}%M"

polybar ws &
[ $POLYBAR_TIME = "True" ] && polybar time &
# polybar ws-tv &
[ $POLYBAR_MUSIC = "True" ] && polybar music &
polybar sysinfo &
polybar sysinfo-laptop &
polybar ws-flags &
