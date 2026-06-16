#!/bin/bash
# Decoupled interactive pacman sync database installer using fzf multi-select

# Dependencies Check
for cmd in pacman fzf xargs; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "Error: $cmd is required but not installed." >&2
    exit 1
  fi
done

# Define clean FZF configuration mimicking the layout
fzf_args=(
  --multi
  --ansi
  --prompt="Select Official Repo Packages > "
  # Extracts the package name after the '/' slash for reliable pacman -Si queries
  --preview 'pacman -Si $(echo {1} | cut -d/ -f2) 2>/dev/null || echo "No preview available"'
  --preview-label=' [ Alt+P: Toggle Details | Tab: Select Multiple ] '
  --preview-label-pos='bottom'
  --preview-window 'down:65%:wrap'
  --bind 'alt-p:toggle-preview'
  --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
  --bind 'alt-k:preview-up,alt-j:preview-down'
  --color 'pointer:10,marker:10,hl:2,hl+:2'
)

# Fetch system repositories, format clean output line: "repo/package_name"
# Filter out currently installed packages to keep the list clean
pkg_selection=$(pacman -Sl | awk '!/\\[installed\\]/ {print $1 "/" $2}' | fzf "${fzf_args[@]}")

# Execute installation sequence if selection string is populated
if [[ -n "$pkg_selection" ]]; then
  clear

  # Strip the repo prefix (e.g., "extra/neovim" -> "neovim") for pacman ingestion
  clean_pkgs=$(echo "$pkg_selection" | awk -F'/' '{print $2}' | tr '\n' ' ')

  echo "Preparing to install selected targets:"
  echo "$clean_pkgs" | tr ' ' '\n' | sed 's/^/  - /'
  echo ""

  # Invoke pacman using sudo
  sudo pacman -S --needed $clean_pkgs

  # Optional metadata indexing refresh
  if command -v updatedb &>/dev/null; then
    sudo updatedb
  fi

  echo -e "\nProcess completed. Press any key to exit."
  read -n 1 -r
fi
