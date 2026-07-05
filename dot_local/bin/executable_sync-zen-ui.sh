#!/bin/bash

PROFILE_DIR="$HOME/.zen/lkjgcjjx.Default (release)-1"
PREFS_FILE="$PROFILE_DIR/prefs.js"
USER_FILE="$PROFILE_DIR/user.js"

# Create user.js if it does not exist
touch "$USER_FILE"

# Extract the latest UI state from prefs.js
NEW_UI_STATE=$(grep '^user_pref("browser.uiCustomization.state",' "$PREFS_FILE" | tail -n 1)

if [[ -n "$NEW_UI_STATE" ]]; then
  # Delete the outdated UI state line from user.js in-place
  sed -i '/^user_pref("browser.uiCustomization.state",/d' "$USER_FILE"

  # Append the newly extracted state
  echo "$NEW_UI_STATE" >>"$USER_FILE"
fi
