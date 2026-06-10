#!/bin/bash
STATE_FILE="/tmp/waybar_marquee_pos"
WIDTH=30

while true; do
  text=$(playerctl metadata --player spotify --format "{{artist}} - {{title}}" 2>/dev/null || echo "Not playing")

  if [ ${#text} -le $WIDTH ]; then
    echo "󰓇 $text"
    sleep 2
    continue
  fi

  separator=" | 󰓇 "
  base_text="${text}${separator}"

  buffer="${base_text}"
  while [ ${#buffer} -lt $((${#base_text} + WIDTH)) ]; do
    buffer="${buffer}${base_text}"
  done

  pos=$(cat "$STATE_FILE" 2>/dev/null || echo 0)

  echo "${buffer:$pos:$WIDTH}"

  next_pos=$((pos + 1))
  if [ $next_pos -ge ${#base_text} ]; then
    next_pos=0
  fi
  echo "$next_pos" >"$STATE_FILE"

  sleep 0.3
done
