#!/bin/bash
# @vicinae.schemaVersion 1
# @vicinae.title Select Hyprlock Layout
# @vicinae.keywords ["hyde", "hyprland"]
# @vicinae.description change the current hyprlock layout of hyprland
# @vicinae.mode silent
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/hyprlock.png

vicinae toggle
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export WAYLAND_DISPLAY="wayland-1"
/home/binaryraptor/.local/lib/hyde/lockscreen.sh -S
