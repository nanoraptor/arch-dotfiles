#!/bin/bash
# @vicinae.schemaVersion 1
# @vicinae.title Select Waybar Layout
# @vicinae.keywords ["hyde", "hyprland"]
# @vicinae.description change the current layout of waybar in hyprland
# @vicinae.mode inline
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/waybar.png

export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export WAYLAND_DISPLAY="wayland-1"

(
  # Fetch layout names, excluding files starting with a dot or containing an underscore
  LAYOUTS=$(find "$HOME/.config/waybar/layouts" "$HOME/.local/share/waybar/layouts" -type f -name "*.jsonc" ! -name ".*" ! -name "*_*" 2>/dev/null | awk -F'/' '{print $NF}' | sed 's/\.jsonc$//' | sort -u)

  [[ -z "$LAYOUTS" ]] && exit 1

  # Pipe to vicinae dmenu
  CHOICE=$(echo -e "$LAYOUTS" | vicinae dmenu --placeholder "Select Waybar Layout")

  [[ -z "$CHOICE" ]] && exit 0

  CHOICE=$(echo "$CHOICE" | tr -d '[:space:]')

  # Apply selected layout using HyDE CLI
  hyde-shell waybar --set "$CHOICE"
) &
disown

exit 0
