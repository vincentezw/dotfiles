
#!/bin/sh

time=(
  background.color=$DARK
  background.corner_radius=12
  background.height=20
  icon.font="$FONT:$TEXT:12.0"
  icon.padding_left=12
  icon.padding_right=3
  icon=
  label.font="$FONT:$TEXT:12.0"
  label.padding_left=0
  label.padding_right=12
  padding_left=5
  padding_right=0
  script="$PLUGIN_DIR/time.sh"
  update_freq=10
)
sketchybar --add item time right \
  --set time "${time[@]}"
