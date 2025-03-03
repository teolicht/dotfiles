#!/bin/bash

source "$CONFIG_DIR/colors.sh"

T_PURPLE_70=0xb3bb9af7

# Highlight focused workspace
if [[ "$1" == "$FOCUSED_WORKSPACE" ]]; then
    sketchybar --set "$NAME" \
        background.border_color="$T_PURPLE_70" \
        background.border_width=2 
else
    sketchybar --set "$NAME" \
        background.border_width=0
fi

