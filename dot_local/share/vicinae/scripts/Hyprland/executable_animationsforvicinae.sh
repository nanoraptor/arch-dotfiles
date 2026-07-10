#!/bin/bash
# @vicinae.schemaVersion 1
# @vicinae.title Select Animation
# @vicinae.keywords ["hyde", "hyprland"]
# @vicinae.description change the current animation of hyprland
# @vicinae.mode inline
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/animations.png

(
  export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

  # Define where HyDE keeps animation configs
  ANIM_DIRS=("$HOME/.config/hypr/animations" "$HOME/.local/share/hyde/animations")

  # Fetch list
  ANIMATIONS=$(find "${ANIM_DIRS[@]}" -type f -name "*.conf" 2>/dev/null | awk -F'/' '{print $NF}' | sed 's/\.conf$//' | sort -u)

  [[ -z "$ANIMATIONS" ]] && exit 1

  # Spawn Dmenu
  CHOICE=$(echo -e "$ANIMATIONS" | vicinae dmenu --placeholder "Select Animation")

  [[ -z "$CHOICE" ]] && exit 0
  CHOICE=$(echo "$CHOICE" | tr -d '[:space:]')

  # Find the exact absolute path of the chosen config
  TARGET_FILE=$(find "${ANIM_DIRS[@]}" -type f -name "${CHOICE}.conf" -print -quit 2>/dev/null)

  [[ -z "$TARGET_FILE" ]] && exit 1

  # Overwrite the active HyDE animation symlink directly
  ln -sf "$TARGET_FILE" "$HOME/.config/hypr/animations.conf"

  # Force Hyprland to process the new config immediately
  hyprctl reload

  # Notification
  notify-send -a "HyDE Alert" -t 2000 -i "/home/binaryraptor/.local/share/vicinae/scripts/icons/animations.png" "Animation Applied" "$CHOICE"
) &
disown

exit 0
