#!/bin/bash
# @vicinae.schemaVersion 1
# @vicinae.title Open Game Launcher
# @vicinae.keywords ["hyde", "hyprland", "game"]
# @vicinae.mode silent
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/game-controller.png

export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export WAYLAND_DISPLAY="wayland-1"
/home/binaryraptor/.local/lib/hyde/gamelauncher.sh
