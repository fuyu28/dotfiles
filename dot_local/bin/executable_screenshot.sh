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

focused_output() {
  swaymsg -t get_outputs | python3 -c '
import json, sys
print(next(o["name"] for o in json.load(sys.stdin) if o["focused"]))
'
}

# On Wayland, region mode opens the focused output in satty with the crop
# tool selected. The crop can be adjusted before Enter writes the result to
# the given file; Enter without a crop keeps the full screen. Escape leaves
# the file empty, which main treats as a cancel. Only a grim failure fails.
edit_capture() {
  local output
  output="$(focused_output)" || return 1
  grim -o "$output" - | {
    satty --filename - \
      --fullscreen current-screen \
      --initial-tool crop \
      --output-filename - \
      --actions-on-enter save-to-file,exit \
      --actions-on-escape exit \
      --disable-notifications >"$1" || true
  }
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
    capture=(edit_capture)
    interactive=1
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
  interactive=0
  prepare_capture

  local shots="$HOME/Pictures/Screenshots" file
  mkdir -p "$shots" || fail "Could not create the screenshot directory."
  temporary="$(mktemp --suffix=.png)" || fail "Could not create a temporary image."
  trap cleanup EXIT

  # Publish only successful captures. Milliseconds keep names unique.
  file="$shots/$(date +%F_%H-%M-%S-%3N).png"
  if ((interactive)); then
    # Retrying would reopen the editor, so an interactive capture runs once.
    "${capture[@]}" "$temporary" || fail "Capture failed. No image was saved."
    if [[ ! -s $temporary ]]; then
      notify "Selection cancelled"
      exit 0
    fi
  else
    capture_with_retry || fail "Capture failed after two attempts. No image was saved."
  fi
  mv -- "$temporary" "$file" || fail "Could not save the screenshot."
  copy_png "$file" || fail "Image saved as ${file##*/}, but copying to the clipboard failed."
  notify "$label"$'\n'"${file##*/}" -i "$file"
}

main "$@"
