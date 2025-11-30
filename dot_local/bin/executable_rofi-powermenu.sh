#!/usr/bin/env bash

# Rofi power menu using shades theme; mirrors i3/polybar actions
dir="$HOME/.config/rofi/shades"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -no-config -theme $dir/powermenu.rasi"

# Options
shutdown=" Shutdown"
reboot=" Restart"
lock=" Lock"
suspend=" Sleep"
switchuser=" Switch user"
logout=" Logout"

# Confirmation
confirm_exit() {
  rofi -dmenu \
    -no-config \
    -i \
    -no-fixed-num-lines \
    -p "Are You Sure? : " \
    -theme "$dir/confirm.rasi"
}

# Message
msg() {
  rofi -no-config -theme "$dir/message.rasi" -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$lock\n$suspend\n$switchuser\n$logout\n$reboot\n$shutdown"

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
  if [[ -x /usr/bin/betterlockscreen ]]; then
    betterlockscreen -l
  elif [[ -x /usr/bin/i3lock ]]; then
    i3lock
  fi
  ;;
$suspend)
  ans=$(confirm_exit &)
  if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
    ~/.local/bin/suspend-lock.sh
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
    i3exit logout
  elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
    exit 0
  else
    msg
  fi
  ;;
esac
