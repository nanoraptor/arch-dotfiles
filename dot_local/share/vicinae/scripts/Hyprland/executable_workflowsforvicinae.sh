#!/bin/bash
# @vicinae.schemaVersion 1
# @vicinae.title Select Workflow
# @vicinae.keywords ["hyde", "hyprland", "Profile", "power profile"]
# @vicinae.description change the current workflow/power profile of hyprland
# @vicinae.mode inline
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/workflow.png

(
  export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

  WORKFLOW_DIRS=("$HOME/.config/hypr/workflows" "$HOME/.local/share/hyde/workflows")
  USERPREFS="$HOME/.config/hypr/userprefs.conf"

  # Fetch list of .conf files
  WORKFLOWS=$(find "${WORKFLOW_DIRS[@]}" -type f -name "*.conf" 2>/dev/null | awk -F'/' '{print $NF}' | sed 's/\.conf$//' | sort -u)

  # Remove 'default' and 'no-blur' from the dynamically found list to prevent duplicates
  if [[ -n "$WORKFLOWS" ]]; then
    WORKFLOWS=$(echo "$WORKFLOWS" | grep -v -E '^(default|no-blur)$')
  fi

  # Inject 'default' first, then 'no-blur' at the top of the list
  if [[ -n "$WORKFLOWS" ]]; then
    WORKFLOWS=$(echo -e "default\nno-blur\n$WORKFLOWS")
  else
    WORKFLOWS=$(echo -e "default\nno-blur")
  fi

  # Spawn Dmenu
  CHOICE=$(echo -e "$WORKFLOWS" | vicinae dmenu --placeholder "Select Workflow")

  [[ -z "$CHOICE" ]] && exit 0

  # Clean whitespace
  CHOICE=$(echo "$CHOICE" | tr -d '[:space:]')

  # Handle no-blur explicitly
  if [[ "$CHOICE" == "no-blur" ]]; then
    sed -i 's/.*decoration:blur:enabled.*/decoration:blur:enabled = false/' "$USERPREFS"
    hyprctl reload
    notify-send -a "HyDE Alert" -t 2000 -i "/home/binaryraptor/.local/share/vicinae/scripts/icons/workflow.png" "Workflow Applied" "no-blur"
    exit 0
  fi

  # Ensure blur is enabled for all other selections (including 'default')
  sed -i 's/.*decoration:blur:enabled.*/decoration:blur:enabled = true/' "$USERPREFS"

  # Find the exact absolute path of the chosen config
  TARGET_FILE=$(find "${WORKFLOW_DIRS[@]}" -type f -name "${CHOICE}.conf" -print -quit 2>/dev/null)

  if [[ -n "$TARGET_FILE" ]]; then
    # Overwrite the active HyDE workflow symlink directly
    ln -sf "$TARGET_FILE" "$HOME/.config/hypr/workflows.conf"

    # Force Hyprland to process the new config immediately
    hyprctl reload

    # Notification
    notify-send -a "HyDE Alert" -t 2000 -i "/home/binaryraptor/.local/share/vicinae/scripts/icons/workflow.png" "Workflow Applied" "$CHOICE"
  else
    # Fallback just in case the HyDE structure is different
    /home/binaryraptor/.local/lib/hyde/workflows.sh -s "$CHOICE"
  fi

) &
disown

exit 0
