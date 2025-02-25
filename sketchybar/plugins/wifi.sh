#!/bin/sh

WIFI_NAME="$(networksetup -listpreferredwirelessnetworks en0 | sed -n '2 p' | tr -d '\t')"
host="apple.com"
ping -c1 "$host" &> /dev/null
if [ $? -eq 0 ]; then
    ICON=􀙇
    ICON_COLOR=0xffffffff
else
    ICON=􀙈
    ICON_COLOR=0xffff5e5e
fi

sketchybar --set "$NAME" \
    icon="$ICON" \
    icon.color="$ICON_COLOR" \
    label="$WIFI_NAME"
