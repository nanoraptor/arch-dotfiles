#!/bin/bash
# Decoupled interactive AUR package installer using fzf multi-select

# Dependencies Check
for cmd in yay fzf xargs; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "Error: $cmd is required but not installed." >&2
    exit 1
  fi
done

# Define clean FZF configuration mimicking the native TUI layout
fzf_args=(
  --multi
  --ansi
  --prompt="Select AUR Packages > "
  --preview 'yay -Siia {1} 2>/dev/null || echo "No preview available"'
  --preview-label=' [ Alt+P: Toggle Details | Tab: Select Multiple ] '
  --preview-label-pos='bottom'
  --preview-window 'down:65%:wrap'
  --bind 'alt-p:toggle-preview'
  --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
  --bind 'alt-k:preview-up,alt-j:preview-down'
  --bind 'alt-b:change-preview:yay -Gpa {1} 2>/dev/null | tail -n +5'
  --bind 'alt-B:change-preview:yay -Siia {1}'
  --color 'pointer:10,marker:10,hl:2,hl+:2'
)

# Fetch all available package strings and pipe into fzf layout
pkg_names=$(yay -Slqa | fzf "${fzf_args[@]}")

# Execute installation sequence if selection string is populated
if [[ -n "$pkg_names" ]]; then
  clear
  echo "Preparing to install selected targets..."

  # Pre-auth sudo token validation to ensure installer pipeline doesn't block mid-stream
  sudo -v
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done 2>/dev/null &

  # Map selection elements explicitly using aur/ target definitions
  echo "$pkg_names" | sed 's/^/aur\//' | tr '\n' ' ' | xargs yay -S --noconfirm

  # Optional metadata indexing refresh
  if command -v updatedb &>/dev/null; then
    sudo updatedb
  fi

  echo -e "\nInstallation completed. Press any key to exit."
  read -n 1 -r
fi
