#!/bin/sh

spotify=(
  padding_left=15
  background.color=$DARK
  background.corner_radius=12
  background.height=20
  background.padding_left=0
  label.font="$FONT:$TEXT:12.0"
  label.padding_left=12
  label.padding_right=12
  script="$PLUGIN_DIR/spotify/get.sh"
  update_freq=30
)
sketchybar --add item spotify center \
  --set spotify "${spotify[@]}"
