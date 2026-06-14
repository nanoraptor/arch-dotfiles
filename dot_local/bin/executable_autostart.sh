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
keepassxc &
