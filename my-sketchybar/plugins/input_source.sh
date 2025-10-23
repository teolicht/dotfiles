#!/bin/bash

INPUT_SOURCE="$(macism | awk -F '.' '{print $NF}')"

if [[ "$INPUT_SOURCE" == "US" ]]; then
    sketchybar --set "$NAME" \
        label="US"
elif  [[ "$INPUT_SOURCE" == "Danish" ]]; then
    sketchybar --set "$NAME" \
        label="DA"
else
    sketchybar --set "$NAME" \
        label="$INPUT_SOURCE"
fi
