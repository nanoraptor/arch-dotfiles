#!/bin/bash
STATE_FILE="/tmp/waybar_marquee_pos"
WIDTH=30

while true; do
  status=$(playerctl status --player spotify 2>/dev/null || echo "Stopped")
  text=$(playerctl metadata --player spotify --format "{{artist}} - {{title}}" 2>/dev/null || echo "Not playing")

  # Add Play icon suffix only if paused/stopped. Adjusted size via Pango markup.
  # Change '150%' to 'large', 'x-large', or a specific pixel size (e.g., '14pt') if preferred.
  suffix=""
  if [ "$status" != "Playing" ] && [ "$text" != "Not playing" ]; then
    suffix=" <span size='120%'>󰐊</span>"
  fi

  if [ "$status" != "Playing" ] || [ ${#text} -le $WIDTH ]; then
    if [ ${#text} -gt $WIDTH ]; then
      echo "󰓇 ${text:0:$((WIDTH - 3))}...${suffix}"
    else
      echo "󰓇 ${text}${suffix}"
    fi
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
