#!/bin/sh

weather=(
  padding_left=15
  background.color=$DARK
  background.corner_radius=12
  background.height=20
  background.padding_left=0
  background.padding_right=5
  label.font="$FONT:$TEXT:12.0"
  label.padding_left=12
  label.padding_right=12
  script="$PLUGIN_DIR/weather.sh"
  update_freq=1500
)
sketchybar --add item weather center \
  --set weather "${weather[@]}"
