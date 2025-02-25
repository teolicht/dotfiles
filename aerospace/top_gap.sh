#!/bin/bash

# Check if the external monitor is connected using displayplacer
external_monitor_connected=$(displayplacer list | grep -i "27 inch" | wc -l)

config_file="$HOME/.config/aerospace/aerospace.toml"

if [ "$external_monitor_connected" -gt 0 ]; then
    # External monitor detected, set the gap to 40
    sed -i '' 's/outer.top = 10/outer.top = 45/' "$config_file"
else
    # External monitor not detected, revert to 20
    sed -i '' 's/outer.top = 45/outer.top = 10/' "$config_file"
fi

$(aerospace reload-config)

