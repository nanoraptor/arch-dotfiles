#!/usr/bin/env bash

# Wait for Waybar process
while ! pgrep -x waybar >/dev/null; do sleep 1; done

# Critical buffer: Waybar takes an additional 2-3 seconds to expose the system tray over DBus
sleep 2

# Applications (Trapped by windowrulev2)
spotify &
discord --start-minimized &
thunderbird &
google-chrome-stable --profile-directory="Default" --app="https://gemini.google.com/app" &
vicinae server &

sed -i '$ s/^#\s*//' ~/.config/hypr/userprefs.conf
zapzap --hideStart &
for i in {1..20}; do
  if hyprctl clients -j | grep -q "com.rtosta.zapzap"; then
    hyprctl dispatch closewindow class:com.rtosta.zapzap

    # Comment last line back out
    sed -i '$ s/^\([^#]\)/# \1/' ~/.config/hypr/userprefs.conf
    break
  fi
  sleep 0.25
done

keepassxc &
