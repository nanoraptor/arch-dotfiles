#!/bin/bash
# @vicinae.schemaVersion 1
# @vicinae.title Install a Package
# # @vicinae.keywords ["pacman", "packages", "install"]
# @vicinae.mode silent
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/arch.png

# Launch terminal in the background and detach it completely
kitty --class floating_tui_installer -e ~/.local/bin/pacman-installer.sh &
# Print message for Vicinae to display in its notification/output UI
echo "Pacman"
# Exit immediately so Vicinae closes its window
exit 0
