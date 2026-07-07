#!/usr/bin/env bash

PID_FILE="/tmp/waybar_caffeine.pid"

if [[ "$1" == "toggle" ]]; then
  if [[ -f "$PID_FILE" ]]; then
    kill -9 "$(cat "$PID_FILE")" 2>/dev/null
    rm -f "$PID_FILE"
  else
    wayland-idle-inhibitor >/dev/null 2>&1 &
    echo $! >"$PID_FILE"
  fi
  pkill -RTMIN+8 waybar
  exit 0
fi

if [[ "$1" == "status" ]]; then
  if [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
    echo '{"alt": "activated", "class": "activated", "tooltip": "Caffeine Active"}'
  else
    rm -f "$PID_FILE"
    echo '{"alt": "deactivated", "class": "deactivated", "tooltip": "Caffeine Inactive"}'
  fi
fi
