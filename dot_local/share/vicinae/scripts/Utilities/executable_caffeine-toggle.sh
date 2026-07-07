#!/bin/bash
# @vicinae.schemaVersion 1
# @vicinae.title Toggle Caffeine Mode
# @vicinae.keywords ["caffeine", "idle", "inhibit", "toggle"]
# @vicinae.description toggles the caffeine mode - prevents screen from going off
# @vicinae.mode silent
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/caffeine.png
#!/usr/bin/env bash

# Trigger the existing script to handle the toggle and Waybar UI update
~/.local/bin/caffeine.sh toggle

# Check the PID file to determine and echo the new state
if [[ -f "/tmp/waybar_caffeine.pid" ]]; then
  echo "󰅶: caffeine mode on"
else
  echo "󰛊: caffeine mode off"
fi
