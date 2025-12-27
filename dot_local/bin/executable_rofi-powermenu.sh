#!/usr/bin/env bash

# Rofi power menu using shades theme; mirrors i3/polybar actions
dir="$HOME/.config/rofi/shades"
# fallback to base config if shades isn't available
if [[ ! -d "$dir" ]]; then
  dir="$HOME/.config/rofi"
fi

uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -no-config -theme $dir/powermenu.rasi"

# Options
shutdown=" Shutdown"
reboot=" Restart"
lock=" Lock"
suspend=" Sleep"
hibernate=" Hibernate"
switchuser=" Switch user"
logout=" Logout"

confirm_exit() {
  rofi -dmenu \
    -no-config \
    -i \
    -no-fixed-num-lines \
    -p "Are You Sure? : " \
    -theme "$dir/confirm.rasi"
}

msg() {
  rofi -no-config -theme "$dir/message.rasi" -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$lock\n$suspend\n$hibernate\n$switchuser\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
case $chosen in
$shutdown)
  ans=$(confirm_exit &)
  if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
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
  if command -v betterlockscreen >/dev/null 2>&1; then
    betterlockscreen -l
  fi
  ;;
$suspend)
  ans=$(confirm_exit &)
  if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
    betterlockscreen -s
  elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
    exit 0
  else
    msg
  fi
  ;;
$hibernate)
  ans=$(confirm_exit &)
  if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
    # lock then hibernate; betterlockscreen does not wrap hibernate directly
    if betterlockscreen -l; then
      systemctl hibernate
    fi
  elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
    exit 0
  else
    msg
  fi
  ;;
$switchuser)
  ans=$(confirm_exit &)
  if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
    loginctl lock-session && gdmflexiserver
  elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
    exit 0
  else
    msg
  fi
  ;;
$logout)
  ans=$(confirm_exit &)
  if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
    i3-msg exit
  elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
    exit 0
  else
    msg
  fi
  ;;
esac
