#!/bin/sh

front_app=(
  background.height=20
  label.font="$FONT:Black:12.0"
  icon.background.drawing=on
  icon.background.image.padding_left=4
  label.padding_left=5
  label.padding_right=15
  script="$PLUGIN_DIR/front_app.sh"
  click_script="open -a 'Mission Control'"
  background.color=$BUBBLE_ACTIVE_BG
  background.corner_radius=12
  background.padding_right=5
)
sketchybar --add item front_app center \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched
