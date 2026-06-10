#!/bin/bash
STATE_FILE="/tmp/waybar_marquee_pos"
WIDTH=35

while true; do
  text=$(playerctl metadata --player spotify --format "{{artist}} - {{title}}" 2>/dev/null || echo "Not playing")

  # Static output if text fits within WIDTH
  if [ ${#text} -le $WIDTH ]; then
    echo "$text"
    sleep 2
    continue
  fi

  # 1. Separator to prevent the end and beginning from visually merging
  separator=" • "
  base_text="${text}${separator}"

  # 2. Build a circular buffer
  buffer="${base_text}"
  while [ ${#buffer} -lt $((${#base_text} + WIDTH)) ]; do
    buffer="${buffer}${base_text}"
  done

  pos=$(cat "$STATE_FILE" 2>/dev/null || echo 0)

  # 3. Output the exact slice
  echo "${buffer:$pos:$WIDTH}"

  # 4. Increment and reset
  next_pos=$((pos + 1))
  if [ $next_pos -ge ${#base_text} ]; then
    next_pos=0
  fi
  echo "$next_pos" >"$STATE_FILE"

  sleep 0.3
done
