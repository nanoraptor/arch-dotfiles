#!/bin/bash
# @vicinae.schemaVersion 1
# @vicinae.title Select Wallbash Mode
# @vicinae.keywords ["hyde", "hyprland"]
# @vicinae.description change the current wallbash mode of hyprland
# @vicinae.mode silent
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/wallbash.png

export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export WAYLAND_DISPLAY="wayland-1"

/home/binaryraptor/.local/lib/hyde/wallbashtoggle.sh -m
