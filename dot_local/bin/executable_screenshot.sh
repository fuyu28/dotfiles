#!/usr/bin/env bash
set -euo pipefail

notify() {
  notify-send "📸 Screenshot" "$@" || true
}

fail() {
  printf '%s\n' "$1" >&2
  notify-send -u critical "📸 Screenshot failed" "$1" || true
  exit 1
}

copy_png() {
  if [[ -n ${WAYLAND_DISPLAY:-} ]]; then
    wl-copy -t image/png <"$1"
  else
    xclip -selection clipboard -t image/png -i <"$1"
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

prepare_capture() {
  local backend=x11 geometry window
  [[ -z ${WAYLAND_DISPLAY:-} ]] || backend=wayland

  case "$mode" in
  region) label="Region captured" ;;
  full) label="Full screen captured" ;;
  window) label="Window captured" ;;
  *)
    printf 'Usage: %s {region|full|window}\n' "$0" >&2
    exit 1
    ;;
  esac

  case "$backend:$mode" in
  wayland:region)
    if ! geometry="$(slurp)" || [[ -z $geometry ]]; then
      notify "Selection cancelled or unavailable"
      exit 0
    fi
    capture=(grim -g "$geometry")
    ;;
  wayland:full)
    capture=(grim)
    ;;
  wayland:window)
    geometry="$(focused_geometry)" && [[ -n $geometry ]] ||
      fail "Could not determine the focused window."
    capture=(grim -g "$geometry")
    ;;
  x11:region)
    capture=(maim -s)
    ;;
  x11:full)
    capture=(maim)
    ;;
  x11:window)
    window="$(xdotool getactivewindow)" && [[ -n $window ]] ||
      fail "Could not determine the active window."
    capture=(maim -i "$window")
    ;;
  esac
}

capture_with_retry() {
  local attempt
  for attempt in 1 2; do
    : >"$temporary"
    if "${capture[@]}" "$temporary" && [[ -s $temporary ]]; then
      return 0
    fi
    if [[ $attempt == 1 ]]; then
      notify "Capture failed; retrying once"
      sleep 0.2
    fi
  done
  return 1
}

cleanup() {
  python3 - "$temporary" <<'PY_CLEANUP'
import os
import sys
try:
    os.unlink(sys.argv[1])
except FileNotFoundError:
    pass
PY_CLEANUP
}

main() {
  mode="${1:-}"
  prepare_capture

  local shots="$HOME/Pictures/Screenshots" file
  mkdir -p "$shots" || fail "Could not create the screenshot directory."
  temporary="$(mktemp --suffix=.png)" || fail "Could not create a temporary image."
  trap cleanup EXIT

  # Publish only successful captures. The random suffix prevents collisions.
  file="$shots/$(date +%F_%H-%M-%S)_${temporary##*/}"
  capture_with_retry || fail "Capture failed after two attempts. No image was saved."
  mv -- "$temporary" "$file" || fail "Could not save the screenshot."
  copy_png "$file" || fail "Image saved as ${file##*/}, but copying to the clipboard failed."
  notify "$label"$'\n'"${file##*/}" -i "$file"
}

main "$@"
