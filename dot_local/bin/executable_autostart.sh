#!/usr/bin/env bash

# Wait for Waybar process
while ! pgrep -x waybar >/dev/null; do sleep 1; done

# Critical buffer: Waybar takes an additional 2-3 seconds to expose the system tray over DBus
sleep 2

# Applications (Trapped by windowrule)
spotify &
discord --start-minimized &
thunderbird &
firefoxpwa site launch 01KW5ZXG7VG360Z11W00D22ZCB
zapzap --hideStart
kdeconnect-indicator

keepassxc &
