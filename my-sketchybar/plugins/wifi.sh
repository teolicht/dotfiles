#!/bin/bash

source "$CONFIG_DIR/colors.sh"

WIFI_NAME="$(networksetup -listpreferredwirelessnetworks en0 | sed -n '2 p' | tr -d '\t')"
ping -c1 "apple.com" &> /dev/null
if [ $? -eq 0 ]; then
  ICON=􀙇
  COLOR="$WHITE"
else
  ICON=􀙈
  COLOR="$RED"
fi

sketchybar --set "$NAME" \
  icon="$ICON" \
  icon.color="$COLOR" \
  label="$WIFI_NAME"
