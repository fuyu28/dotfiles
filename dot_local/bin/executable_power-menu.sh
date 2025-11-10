#!/usr/bin/env bash
set -euo pipefail

choice="$(printf '🔒 Lock\n💤 Suspend\n🚪 Logout\n⛔ Shutdown\n🔄 Reboot' | rofi -dmenu -p 'Power')"

case "$choice" in
"🔒 Lock")
  # ロックのみ（blur 設定は betterlockscreenrc に従う）
  betterlockscreen -l
  ;;

"💤 Suspend")
  # ロックしてからサスペンド（race回避で短い待機）
  betterlockscreen -l &
  sleep 0.3
  systemctl suspend
  ;;

"🚪 Logout")
  i3exit logout
  ;;

"⛔ Shutdown")
  i3exit shutdown
  ;;

"🔄 Reboot")
  i3exit reboot
  ;;

*) exit 0 ;;
esac
