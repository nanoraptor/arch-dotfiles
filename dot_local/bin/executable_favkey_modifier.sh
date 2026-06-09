#!/bin/bash

# Path to your config file
CONFIG_FILE="$HOME/.config/hypr/keybindings.conf"

# 1. Ask for the new command
# We use a simple terminal read, but you can pipe this into a GUI box if you prefer.
echo "Current Favorite Command:"
grep "run favorite command" "$CONFIG_FILE" | awk -F "exec, " '{print $2}'
echo "-----------------------------------"
read -p "Enter new command for Favorites Key: " NEW_CMD

# 2. Check if empty
if [ -z "$NEW_CMD" ]; then
  echo "No command entered."
  exit 1
fi

# 3. The Magic SED Command
# We search for the literal string: binddel = , XF86Favorites, $d run favorite command , exec, [ANYTHING]
# We replace it with the same prefix + the NEW_CMD
# We must escape the '$' in $d so bash doesn't think it's a variable.

sed -i "s|^binddel = , XF86Favorites, \$d run favorite command , exec, .*|binddel = , XF86Favorites, \$d run favorite command , exec, $NEW_CMD|" "$CONFIG_FILE"

echo "Updated to: $NEW_CMD"
sleep 1
