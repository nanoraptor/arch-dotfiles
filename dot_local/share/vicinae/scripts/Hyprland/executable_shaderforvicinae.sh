#!/bin/bash
# @vicinae.schemaVersion 1
# @vicinae.title Select Shader
# @vicinae.keywords ["hyde", "hyprland", "Night light", "Blue light filter"]
# @vicinae.description change the current shader of hyprland
# @vicinae.mode inline
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/shader.png

(
  export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
  export XDG_RUNTIME_DIR="/run/user/$(id -u)"
  export WAYLAND_DISPLAY="wayland-1"

  SHADER_DIRS=(
    "$HOME/.config/hypr/shaders"
    "$HOME/.local/share/hyde/shaders"
    "$HOME/.config/hyprshade/shaders"
    "/usr/share/hyprshade/shaders"
  )

  # Fetch list, excluding 'disable' (which we will add manually) and any files starting with 'off' or '.'
  SHADERS=$(find "${SHADER_DIRS[@]}" -type f \( -name "*.frag" -o -name "*.glsl" \) ! -name ".*" ! -name "disable*" ! -name "off*" 2>/dev/null | awk -F'/' '{print $NF}' | sed -E 's/\.(frag|glsl)$//' | sort -u)

  [[ -z "$SHADERS" ]] && exit 1

  # Add 'disable' as the first option
  OPTIONS="disable\n$SHADERS"

  CHOICE=$(echo -e "$OPTIONS" | vicinae dmenu --placeholder "Select Shader")

  [[ -z "$CHOICE" ]] && exit 0

  if [[ "$CHOICE" == "disable" ]]; then
    hyprctl keyword decoration:screen_shader "[[EMPTY]]"
    notify-send -a "HyDE Alert" -t 2000 -i "/home/binaryraptor/.local/share/vicinae/scripts/icons/shader.png" "Shader" "Disabled"
    exit 0
  fi

  TARGET_FILE=$(find "${SHADER_DIRS[@]}" -type f \( -name "${CHOICE}.frag" -o -name "${CHOICE}.glsl" \) -print -quit 2>/dev/null)

  [[ -z "$TARGET_FILE" ]] && exit 1

  hyprctl keyword decoration:screen_shader "$TARGET_FILE"

  notify-send -a "HyDE Alert" -t 2000 -i "/home/binaryraptor/.local/share/vicinae/scripts/icons/shader.png" "Shader Applied" "$CHOICE"
) &
disown

exit 0
