#!/bin/bash
# @vicinae.schemaVersion 1
# @vicinae.title Install AUR Package
# @vicinae.keywords ["aur", "packages", "install", "yay"]
# @vicinae.mode silent
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/arch.png

# Launch terminal in the background and detach it completely
vicinae toggle
kitty --class floating_tui_installer -e ~/.local/bin/aur-installer.sh &
# Print message for Vicinae to display in its notification/output UI
echo "AUR"
# Exit immediately so Vicinae closes its window
exit 0
