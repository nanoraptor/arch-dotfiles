#!/bin/sh

CONFIG="$HOME/.config/hypr/userprefs.conf"
KEY="decoration:blur:enabled"

# Read current setting from the config file
CURRENT=$(grep -oP "^$KEY\s*=\s*\K(true|false)" "$CONFIG")

if [ "$CURRENT" = "true" ]; then
    NEW="false"
else
    NEW="true"
fi

# Replace the current value with new value
sed -i "s|^\($KEY\s*=\s*\).*$|\1$NEW|" "$CONFIG"

# Apply the change live using hyprctl
hyprctl keyword $KEY $NEW

echo "Blur toggled to $NEW"
