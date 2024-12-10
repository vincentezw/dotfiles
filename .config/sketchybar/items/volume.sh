#!/bin/sh

volume_slider=(
  background.padding_right=12
  icon.drawing=off
  label.drawing=off
  padding_left=3
  padding_right=3
  script="$PLUGIN_DIR/volume.sh"
  slider.background.color=$BUBBLE_BG
  slider.background.corner_radius=12
  slider.background.height=5
  slider.highlight_color=$TEXT
  slider.knob.drawing=on
  slider.knob=""
  updates=on
)

volume_icon=(
  background.color=$DARK
  background.corner_radius=12
  background.height=20
  click_script="$PLUGIN_DIR/volume_click.sh"
  icon.align=left
  icon=󰕾
  icon.color=$TEXT
  icon.font="$FONT:Regular:14.0"
  icon.padding_left=8
  icon.padding_right=8
  label.font="$FONT:Regular:12.0"
  label.padding_right=12
  # label.width=25
  padding_left=0
  padding_right=0
  popup.background.border_color=$BUBBLE_ACTIVE_BG
  popup.background.border_width=2
  popup.background.color=$BUBBLE_BG
  popup.background.corner_radius=7
  popup.blur_radius=5
  popup.y_offset=3
  script="$PLUGIN_DIR/get_volume.sh"
  update_freq=10
)

status_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
)

sketchybar --add slider volume right            \
           --set volume "${volume_slider[@]}"   \
           --subscribe volume volume_change     \
                              mouse.clicked     \
           --add item volume_icon right         \
           --set volume_icon "${volume_icon[@]}"
