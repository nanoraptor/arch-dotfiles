#!/usr/bin/env bash

# Wait until waybar is running
while ! pgrep -x waybar >/dev/null; do
  sleep 1
done

# Optional: Add a 1-2 second buffer to ensure the system tray is ready to catch icons
sleep 2

# Execute special workspace applications via hyprctl
hyprctl dispatch exec "[workspace special:spotify silent] spotify"
hyprctl dispatch exec "[workspace special:discord silent] discord"
hyprctl dispatch exec "[workspace special:mail silent] thunderbird"
hyprctl dispatch exec "[workspace special:AI silent] google-chrome-stable --profile-directory='Default' --app='https://gemini.google.com/app'"

# Execute tray-dependent applications
zapzap --hideStart &
keepassxc &
vicinae server &
