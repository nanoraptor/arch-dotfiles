#!/usr/bin/env bash

DEVICE="elan06fa:00-04f3:327e-touchpad"
STATE_FILE="$XDG_RUNTIME_DIR/touchpad.state"

if [[ ! -f "$STATE_FILE" ]] || grep -q "true" "$STATE_FILE"; then
  hyprctl keyword "device[$DEVICE]:enabled" false
  echo "false" >"$STATE_FILE"
  notify-send -a "System" -i input-touchpad-symbolic -t 2000 "Touchpad" "Disabled"
else
  hyprctl keyword "device[$DEVICE]:enabled" true
  echo "true" >"$STATE_FILE"
  notify-send -a "System" -i input-touchpad-symbolic -t 2000 "Touchpad" "Enabled"
fi
