#!/bin/bash

source "$CONFIG_DIR/colors.sh"


if [[ "$SENDER" == "space_windows_change" ]]; then
    for sid in $(aerospace list-workspaces --all); do
        if [[ $(aerospace list-windows --workspace "$sid" | wc -l) -eq 0 ]]; then
            sketchybar --set space."$sid" \
              label.color=0x4dffffff # white 30% opacity 
        else
            sketchybar --set space."$sid" \
              label.color="$WHITE"
        fi
    done
else
  if [[ "$1" == "$FOCUSED_WORKSPACE" ]]; then
      sketchybar --set "$NAME" \
          background.border_color=0xb6bb9af7 \
          background.border_width=2 
  else
      sketchybar --set "$NAME" \
          background.border_width=0
  fi
fi

