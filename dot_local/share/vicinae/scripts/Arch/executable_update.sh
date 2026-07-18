#!/bin/bash
# @vicinae.schemaVersion 1
# @vicinae.title Update System
# # @vicinae.keywords ["pacman", "aur", "flatpak", "packages", "update"]
# @vicinae.mode silent
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/arch.png

vicinae toggle
# Launch terminal in the background and detach it completely
~/.local/lib/hyde/system.update.sh up &
echo "Update System"
# Exit immediately so Vicinae closes its window
exit 0
