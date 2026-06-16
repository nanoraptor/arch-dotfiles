#!/bin/bash
# @vicinae.schemaVersion 1
# @vicinae.title Preview Workspaces
# @vicinae.keywords ["hyde", "hyprland", "workspace", "window management", "space"]
# @vicinae.description preview workspaces using quickshell
# @vicinae.mode silent
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/workspace.png

hyprctl dispatch scrolloverview:overview toggle
echo "Workspace Preview"
