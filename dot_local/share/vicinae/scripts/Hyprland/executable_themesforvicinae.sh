#!/bin/bash
# @vicinae.schemaVersion 1
# @vicinae.title Select theme
# @vicinae.keywords ["hyde", "hyprland"]
# @vicinae.description change the current theme of hyprland
# @vicinae.mode silent
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/themes.png

vicinae toggle
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export WAYLAND_DISPLAY="wayland-1"
/home/binaryraptor/.local/lib/hyde/themeselect.sh
echo "Theme Selector Closed"
