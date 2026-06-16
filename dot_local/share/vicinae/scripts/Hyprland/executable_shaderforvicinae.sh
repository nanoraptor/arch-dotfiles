#!/bin/bash
# @vicinae.schemaVersion 1
# @vicinae.title Select Shader
# @vicinae.keywords ["hyde", "hyprland", "Night light", "Blue light filter"]
# @vicinae.description change the current shader of hyprland
# @vicinae.mode silent
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/shader.png

export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export WAYLAND_DISPLAY="wayland-1"
/home/binaryraptor/.local/lib/hyde/shaders.sh -S
echo "Shader Selector Closed"
