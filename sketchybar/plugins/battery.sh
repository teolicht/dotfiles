#!/bin/bash

source "$CONFIG_DIR/colors.sh"

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

# COLOR="$GREEN"
# case "${PERCENTAGE}" in
#   9[0-9]|100) ICON=􀛨   
#   ;;
#   [6-8][0-9]) ICON=􀺸
#   ;;
#   [4-5][0-9]) 
#     ICON=􀺶
#     COLOR="$WHITE"
#   ;;
#   [2-3][0-9])
#     ICON=􀺶
#     COLOR="$YELLOW"
#   ;;
#   [1-2][0-9]) 
#     ICON=􀛩
#     COLOR="$RED"
#   ;;
#   *) 
#     ICON=􀛪
#     COLOR="$RED"
# esac

if [[ "$PERCENTAGE" -ge 90 ]]; then
  ICON=􀛨
elif [[ "$PERCENTAGE" -ge 60 ]]; then
  ICON=􀺸
elif [[ "$PERCENTAGE" -ge 40 ]]; then
  ICON=􀺶
elif [[ "$PERCENTAGE" -ge 10 ]]; then
  ICON=􀛩
else
  ICON=􀛪
fi
  
if [[ "$CHARGING" != "" ]]; then
  ICON=􀢋
fi

if [[ "$PERCENTAGE" -ge 60 ]]; then
  COLOR="$GREEN"
elif [[ "$PERCENTAGE" -ge 40 ]]; then
  COLOR="$WHITE"
elif [[ "$PERCENTAGE" -ge 20 ]]; then
  COLOR="$YELLOW"
else
  COLOR="$RED"
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" \
  icon="$ICON" \
  icon.color="$COLOR" \
  label="${PERCENTAGE}%"
