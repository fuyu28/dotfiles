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

copy_png() {
  if [ -n "${WAYLAND_DISPLAY:-}" ]; then
    wl-copy -t image/png < "$file"
  else
    xclip -selection clipboard -t image/png -i < "$file"
  fi
}

focused_geometry() {
  python3 - <<'PY'
import json
import subprocess

tree = json.loads(subprocess.check_output(["swaymsg", "-t", "get_tree"], text=True))

def find(node):
    if node.get("focused"):
        return node
    for child in node.get("nodes", []) + node.get("floating_nodes", []):
        found = find(child)
        if found:
            return found
    return None

win = find(tree)
if win is None or "rect" not in win:
    raise SystemExit(1)
rect = win["rect"]
print(f'{rect["x"]},{rect["y"]} {rect["width"]}x{rect["height"]}')
PY
}

case "${1:-}" in
region)
  if [ -n "${WAYLAND_DISPLAY:-}" ]; then
    grim -g "$(slurp)" "$file"
  else
    maim -s "$file"
  fi
  copy_png
  send_notice "Region captured"
  ;;
full)
  if [ -n "${WAYLAND_DISPLAY:-}" ]; then
    grim "$file"
  else
    maim "$file"
  fi
  copy_png
  send_notice "Full screen captured"
  ;;
window)
  if [ -n "${WAYLAND_DISPLAY:-}" ]; then
    grim -g "$(focused_geometry)" "$file"
  else
    maim -i "$(xdotool getactivewindow)" "$file"
  fi
  copy_png
  send_notice "Window captured"
  ;;
*)
  echo "Usage: $0 {region|full|window}" >&2
  exit 1
  ;;
esac
