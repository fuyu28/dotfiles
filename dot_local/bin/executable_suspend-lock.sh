#!/usr/bin/env bash
set -euo pipefail
betterlockscreen -l &
sleep 0.3
exec systemctl suspend
