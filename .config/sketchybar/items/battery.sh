#!/bin/sh

battery=(
  background.color=$DARK
  background.corner_radius=12
  background.height=20
  icon.font="$FONT:Regular:12.0"
  icon.padding_left=8
  icon.padding_right=8
  label.drawing=on
  label.font="$FONT:$TEXT:12.0"
  label.padding_right=8
  padding_left=5
  padding_right=0
  script="$PLUGIN_DIR/battery.sh"
  update_freq=120
  updates=on
)
sketchybar --add item battery right \
           --set battery "${battery[@]}"\
           --subscribe battery power_source_change system_woke
