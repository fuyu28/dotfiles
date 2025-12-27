#!/usr/bin/env bash
set -euo pipefail

shots="$HOME/Pictures/Screenshots"
mkdir -p "$shots"
timestamp="$(date +%F_%H-%M-%S)"
file="$shots/$timestamp.png"
fname="$(basename "$file")"

send_notice() {
  notify-send "📸 Screenshot" "$1\n$fname" -i "$file"
}

case "${1:-}" in
region)
  maim -s | tee "$file" | xclip -selection clipboard -t image/png -i
  send_notice "Region captured"
  ;;
full)
  maim | tee "$file" | xclip -selection clipboard -t image/png -i
  send_notice "Full screen captured"
  ;;
window)
  maim -i "$(xdotool getactivewindow)" | tee "$file" | xclip -selection clipboard -t image/png -i
  send_notice "Window captured"
  ;;
*)
  echo "Usage: $0 {region|full|window}" >&2
  exit 1
  ;;
esac
