#!/bin/bash

# Get the window index as an argument
window_index=$1

# Map window indices to Nerd Font icons
case "$window_index" in
    0) icon="󰎣" ;;  # Nerd Font icon for 0
    1) icon="󰎦" ;;  # Nerd Font icon for 1
    2) icon="󰎩" ;;  # Nerd Font icon for 2
    3) icon="" ;;  # Nerd Font icon for 3
    4) icon="" ;;  # Nerd Font icon for 4
    5) icon="" ;;  # Nerd Font icon for 5
    6) icon="" ;;  # Nerd Font icon for 6
    7) icon="" ;;  # Nerd Font icon for 7
    8) icon="" ;;  # Nerd Font icon for 8
    9) icon="" ;;  # Nerd Font icon for 9
    *) icon="?" ;;  # Default icon for unknown indices
esac

# Output the icon
echo "$icon"
