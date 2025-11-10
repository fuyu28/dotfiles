#!/usr/bin/env bash
set -euo pipefail

# 1) 履歴を rofi に出す（greenclip -> rofi -dmenu）
sel="$(greenclip print | awk 'NF' | rofi -dmenu -p 'Clipboard' -l 20 -i)"
[ -z "${sel:-}" ] && exit 0

# 2) 選んだ内容をクリップボードへ
printf "%s" "$sel" | xclip -selection clipboard

# 3) フォーカスが戻るまでほんの少し待つ
sleep 0.05

# 4) 通常アプリ向けに Ctrl+V を送る（修飾キーはクリア）
xdotool key --clearmodifiers ctrl+v
