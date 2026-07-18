#!/bin/bash
# @vicinae.schemaVersion 1
# @vicinae.title Toggle On-Screen Keyboard
# @vicinae.keywords ["virtual", "keyboard", "on-screen"]
# @vicinae.description toggles the on-screen keyboard
# @vicinae.mode silent
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/on-screen-keyboard.png

# Change to "wvkbd" if wvkbd-deskintl is not the actual binary name
vicinae toggle
BIN="wvkbd-deskintl"

if pgrep -x "$BIN" >/dev/null; then
  pkill -x "$BIN"
  echo "󰹋  Virtual Keyboard: Off"
else
  # setsid orphans the process so it survives the script exiting
  # Output is piped to a log file to expose silent failures
  setsid "$BIN" -L 300 >/tmp/wvkbd_error.log 2>&1 &
  echo "  Virtual Keyboard: Active"
fi
