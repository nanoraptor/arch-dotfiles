#!/usr/bin/env bash
# @vicinae.schemaVersion 1
# @vicinae.title Toggle Caffeine Mode
# @vicinae.keywords ["caffeine", "idle", "inhibit", "toggle"]
# @vicinae.description toggles the caffeine mode - prevents screen from going off
# @vicinae.mode silent
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/caffeine.png

~/.local/bin/caffeine.sh toggle

if [[ -f "/tmp/waybar_caffeine.pid" ]]; then
  echo " ☕  caffeine-on"
else
  echo " 🫗  caffeine-off"
fi
exit 0
