#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

T_WHITE_30=0x4dffffff

# Dim empty workspaces
for sid in $(aerospace list-workspaces --monitor focused --empty); do
    sketchybar --set space."$sid" label.color="$T_WHITE_30"
done

# Restore non-empty workspaces to full opacity
for sid in $(aerospace list-workspaces --monitor focused --empty no); do
    sketchybar --set space."$sid" label.color="$WHITE"
done

