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
          label.font.style="Black" \
          background.border_color="$PURPLE" \
          background.height=32 \
          background.border_width=2 
  else
      sketchybar --set "$NAME" \
          label.font.style="Black" \
          background.height=34 \
          background.border_width=0
  fi
fi

