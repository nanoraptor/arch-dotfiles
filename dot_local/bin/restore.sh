#!/bin/bash

# --- Configuration & Colors ---
TARGET_DIR="$HOME/.local/share/chezmoi"
REPO_URL="git@github.com:<YOUR_USERNAME>/dotfiles.git"
PKG_LIST="$HOME/.config/packages/pkglist.txt"
FLATPAK_LIST="$HOME/.config/packages/flatpaklist.txt"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

log() { echo -e "${BLUE}${BOLD}::${NC} $1"; }
success() { echo -e "${GREEN}${BOLD}✔${NC} $1"; }
error() {
  echo -e "${RED}${BOLD}✘${NC} $1"
  exit 1
}

# --- Execution ---

# 1. Initialize or Update Repository
if [ -d "$TARGET_DIR" ]; then
  log "Repository already exists at $TARGET_DIR. Updating..."
  cd "$TARGET_DIR" && git pull
else
  log "Initializing chezmoi from ${REPO_URL}..."
  chezmoi init "$REPO_URL"
fi

# 2. Apply dotfiles
log "Applying dotfiles..."
chezmoi apply -v

# 3. Restore System Packages
if [ -f "$PKG_LIST" ]; then
  log "Synchronizing system packages..."
  sudo pacman -S --needed - <"$PKG_LIST"
  success "System packages are up to date."
else
  log "No system package list found, skipping."
fi

# 4. Restore Flatpak Packages
if [ -f "$FLATPAK_LIST" ]; then
  log "Synchronizing Flatpak packages..."
  # 'xargs' reads the file line-by-line; 'install' with '-y' assumes yes
  # If the package is already installed, flatpak simply skips it
  xargs -a "$FLATPAK_LIST" flatpak install -y flathub --user
  success "Flatpak packages are up to date."
else
  log "No Flatpak list found, skipping."
fi

success "Restore complete! Everything is synchronized."
