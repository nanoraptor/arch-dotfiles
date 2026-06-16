#!/bin/bash
# @vicinae.schemaVersion 1
# @vicinae.title Select Workflow
# @vicinae.keywords ["hyde", "hyprland", "Profile", "power profile"]
# @vicinae.description change the current workflow/power profile of hyprland
# @vicinae.mode silent
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/workflow.png

export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export WAYLAND_DISPLAY="wayland-1"
/home/binaryraptor/.local/lib/hyde/workflows.sh -S
echo "Workflow Selector Closed"
