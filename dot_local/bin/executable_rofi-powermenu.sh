#!/usr/bin/env bash
set -euo pipefail

dir="$HOME/.config/rofi/shades"
[[ -d "$dir" ]] || dir="$HOME/.config/rofi"

uptime="$(uptime -p | sed -e 's/^up //')"
rofi_command=(rofi -no-config -theme "$dir/powermenu.rasi")

shutdown="  Shutdown"
reboot="  Restart"
lock="  Lock"
suspend="  Sleep"
hibernate="  Hibernate"
logout="  Logout"

confirm_exit() {
  rofi -dmenu -no-config -i -no-fixed-num-lines -p "Are You Sure? : " -theme "$dir/confirm.rasi"
}

msg() {
  rofi -no-config -theme "$dir/message.rasi" -e "Available Options  -  yes / y / no / n"
}

options="$lock\n$suspend\n$hibernate\n$logout\n$reboot\n$shutdown"
chosen="$(printf '%b' "$options" | "${rofi_command[@]}" -p "Uptime: $uptime" -dmenu -selected-row 0)"

is_yes() { [[ "$1" =~ ^([yY]|[yY][eE][sS])$ ]]; }

case "$chosen" in
"$shutdown")
  ans="$(confirm_exit)" || exit 0
  is_yes "$ans" && systemctl poweroff || msg
  ;;
"$reboot")
  ans="$(confirm_exit)" || exit 0
  is_yes "$ans" && systemctl reboot || msg
  ;;
"$lock")
  if command -v betterlockscreen >/dev/null 2>&1; then
    betterlockscreen -l
  else
    loginctl lock-session
  fi
  ;;
"$suspend")
  ans="$(confirm_exit)" || exit 0
  if is_yes "$ans"; then
    if command -v betterlockscreen >/dev/null 2>&1; then
      betterlockscreen -s
    else
      loginctl lock-session
      systemctl suspend
    fi
  else
    msg
  fi
  ;;
"$hibernate")
  ans="$(confirm_exit)" || exit 0
  if is_yes "$ans"; then
    if command -v betterlockscreen >/dev/null 2>&1; then
      betterlockscreen -l && systemctl hibernate
    else
      # ロック無し休止が嫌ならここで拒否するのが安全
      loginctl lock-session
      systemctl hibernate
    fi
  else
    msg
  fi
  ;;
"$logout")
  ans="$(confirm_exit)" || exit 0
  is_yes "$ans" && i3-msg exit || msg
  ;;
esac
