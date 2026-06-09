#!/bin/bash

# Trigger Polkit authentication
if pkexec /usr/bin/true 2>/dev/null; then
  # Retrieve master password from GNOME Keyring
  PASSWORD=$(secret-tool lookup title "VaultMasterPassword")

  # Optional: Short delay to ensure the target window is focused
  # after you trigger the hotkey
  sleep 0.5

  # "Type" the password directly into the focused window
  echo -n "$PASSWORD" | wtype -
else
  exit 1
fi
