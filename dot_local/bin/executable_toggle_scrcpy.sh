#!/bin/bash

# Define the window class for scrcpy
SCRCPY_CLASS="scrcpy"

# Define the name of the special workspace
WORKSPACE_NAME="scrcpy"

# Check if a window with the class 'scrcpy' exists
# Hyprland's 'hyprctl clients -j' returns JSON for reliable parsing.
WINDOW_COUNT=$(hyprctl clients -j | grep -c "class\":\"$SCRCPY_CLASS\"")

if [ "$WINDOW_COUNT" -gt 0 ]; then
  # 1. Scrcpy IS running: Simply toggle the special workspace.
  # This brings the workspace (and the already-running app) into view,
  # or hides it if it's already visible.
  hyprctl dispatch togglespecialworkspace "$WORKSPACE_NAME"

else
  # 2. Scrcpy is NOT running: Launch the app.
  # The 'windowrulev2' in hyprland.conf will automatically put it
  # in the correct special workspace.
  # We use '[workspace special:scrcpy]' to ensure the current view
  # switches to that workspace first, so the window appears there immediately.
  # Note: 'exec' replaces the current shell, so it should be the last command.
  hyprctl dispatch exec [workspace special:"$WORKSPACE_NAME"] scrcpy
fi
