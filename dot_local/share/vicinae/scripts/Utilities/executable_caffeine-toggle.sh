#!/usr/bin/env bash
# @vicinae.schemaVersion 1
# @vicinae.title Toggle Caffeine Mode
# @vicinae.keywords ["caffeine", "idle", "inhibit", "toggle"]
# @vicinae.description toggles the caffeine mode - prevents screen from going off
# @vicinae.mode silent
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/caffeine.png
# @vicinae.argument1 { "type": "text", "placeholder": "action (e.g. status)", "optional": true }

if [[ "$1" == "status" ]]; then
  if [[ -f "/tmp/waybar_caffeine.pid" ]]; then
    echo "caffiene-status:on"
  else
    echo "caffeine-status:off"
  fi
  exit 0
fi

~/.local/bin/caffeine.sh toggle

if [[ -f "/tmp/waybar_caffeine.pid" ]]; then
  echo " ☕  caffeine-on"
else
  echo " 🫗  caffeine-off"
fi
