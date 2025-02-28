#!/bin/bash

source "$CONFIG_DIR/colors.sh"

if [[ "$1" == "$FOCUSED_WORKSPACE" ]]; then
    sketchybar --set "$NAME" \
        label.font.style="Black" \
        background.color="$BLACK_60"
else
    sketchybar --set "$NAME" \
        label.font.style="Black" \
        background.color="$BLACK_80"
fi

