#!/bin/bash

# --- Configuration & Colors ---
AUR_LIST="$HOME/.config/packages/aurlist.txt"
PKG_LIST="$HOME/.config/packages/pkglist.txt"
FLATPAK_LIST="$HOME/.config/packages/flatpaklist.txt"
TARGET_DIR="$HOME/.local/share/chezmoi"
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Helper for status messages
log() {
  echo -e "${BLUE}${BOLD}::${NC} $1"
}

success() {
  echo -e "${GREEN}${BOLD}✔${NC} $1"
}

error() {
  echo -e "${RED}${BOLD}✘${NC} $1"
  exit 1
}

# --- Execution ---

mkdir -p "$HOME/.config/packages/"

log "Backing up package lists..."
pacman -Qqem >"$AUR_LIST"
pacman -Qqen >"$PKG_LIST"
flatpak list --app --columns=application >"$FLATPAK_LIST"
success "Package lists saved to ${BOLD}~/.config/packages/"

log "Running chezmoi status..."
chezmoi status

log "Source files are being overriden"
chezmoi status | sed -n 's/^DA //p' | while read -r file; do chezmoi forget --force "$file"; done

log "Updating chezmoi state..."
chezmoi re-add

cd "$TARGET_DIR" || error "Directory '$TARGET_DIR' not found."

log "Committing changes to git..."
git add .
MSG="Backup: $(date +'%Y-%m-%d %H:%M:%S')"
git commit -m "$MSG" >/dev/null

log "Pushing to remote..."
git push >/dev/null 2>&1
if [ $? -eq 0 ]; then
  success "Dotfiles successfully pushed to remote!"
else
  error "Failed to push to remote. Check your internet connection."
fi
