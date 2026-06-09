#!/bin/bash
AUR_LIST="$HOME/.config/packages/aurlist.txt"
PKG_LIST="$HOME/.config/packages/pkglist.txt"
mkdir -p "$HOME/.config/packages/"
pacman -Qqem >"$AUR_LIST"
pacman -Qqen >"$PKG_LIST"
echo "Package lists have been backed up"

chezmoi status
chezmoi re-add
TARGET_DIR="$HOME/.local/share/chezmoi"
cd "$TARGET_DIR" || {
  echo "Error: Directory '$TARGET_DIR' not found."
  exit 1
}
git add .
MSG="Auto-commit: $(date +'%Y-%m-%d %H:%M:%S')"
git commit -m "$MSG"
git push
echo "dotfiles have been backed up and pushed to remote"
