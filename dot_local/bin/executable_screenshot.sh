#!/usr/bin/env bash
set -euo pipefail

shots="$HOME/Pictures/Screenshots"
mkdir -p "$shots"
timestamp="$(date +%F_%H-%M-%S)"
file="$shots/$timestamp.png"

case "${1:-}" in
region)
  maim -s | tee "$file" | xclip -selection clipboard -t image/png -i
  notify-send "📸 Screenshot" "選択範囲を保存しました\n$file" -i "$file"
  ;;
full)
  maim | tee "$file" | xclip -selection clipboard -t image/png -i
  notify-send "📸 Screenshot" "全画面を保存しました\n$file" -i "$file"
  ;;
window)
  maim -i "$(xdotool getactivewindow)" | tee "$file" | xclip -selection clipboard -t image/png -i
  notify-send "📸 Screenshot" "ウィンドウを保存しました\n$file" -i "$file"
  ;;
*)
  echo "Usage: $0 {region|full|window}" >&2
  exit 1
  ;;
esac
