#!/bin/bash
# @vicinae.schemaVersion 1
# @vicinae.title Color Picker
# @vicinae.keywords ["picker", "hyprpicker", "color"]
# @vicinae.description copy the hex code of any color anywhere in the screen
# @vicinae.mode silent
# @vicinae.icon /home/binaryraptor/.local/share/vicinae/scripts/icons/color-picker.png

vicinae toggle
hyprpicker -a
exit 0
