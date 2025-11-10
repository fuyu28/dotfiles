#!/usr/bin/env bash

# スクリーンショット
magick import -window root /tmp/lock.png

# ぼかし
magick /tmp/lock.png -blur 0x6 /tmp/lock-blur.png

# ロック
i3lock \
  --image /tmp/lock-blur.png \
  --indicator \
  --clock \
  --time-color=ffffff \
  --date-color=cccccc \
  --inside-color=00000033 \
  --ring-color=ffffff88 \
  --ring-ver-color=66ff66ff \
  --ring-wrong-color=ff6666ff \
  --keyhl-color=88ffffff \
  --bshl-color=ff8888ff

rm /tmp/lock.png /tmp/lock-blur.png
