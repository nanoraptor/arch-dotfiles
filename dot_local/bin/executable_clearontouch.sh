#!/bin/bash

# Check for the correct number of arguments
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <path/to/file>"
  exit 1
fi

FILE_PATH="$1"

# Check if wl-copy is available
if ! command -v wl-copy &>/dev/null; then
  echo "Error: 'wl-copy' not found. Please ensure it is installed (usually part of the wl-clipboard package)."
  exit 1
fi

# Use a subshell to copy the content
# We run the sleep and clear commands in the background (&) so the main script can exit immediately.
(
  # 1. Copy the content to the clipboard
  cat "$FILE_PATH" | wl-copy

  # 2. Wait 5 seconds
  sleep 5

  # 3. Clear the clipboard (by copying an empty string)
  echo -n "" | wl-copy

  # Optional: Send a notification when the clipboard is cleared
  # if you want feedback on the operation's end.
  # notify-send "Clipboard" "Clipboard content cleared after 5 seconds." -t 1500
) & # The '&' runs the entire block in the background
