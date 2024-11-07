#!/bin/sh

sketchybar --add event aerospace_workspace_change

for m in $(aerospace list-monitors | awk '{print $1}'); do
  for i in $(aerospace list-workspaces --monitor $m); do
    sid=$i
    space=(
      background.color=$DARK
      background.corner_radius=12
      background.height=20
      background.padding_left=0
      background.padding_right=0
      display=$m
      icon.font="$FONT:Heavy:14.0"
      icon.padding_left=10
      icon.padding_right=2
      icon.y_offset=-1
      icon="$sid"
      label.font="sketchybar-app-font:Regular:14.0"
      label.padding_right=15
      label.y_offset=-1
      padding_left=12
      padding_right=4
      script="$PLUGIN_DIR/spaces.sh"
      space="$sid"
    )

    sketchybar --add space space.$sid left \
               --set space.$sid "${space[@]}" \
               --subscribe space.$sid mouse.clicked

    apps=$(aerospace list-windows --workspace $sid | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

    icon_strip=" "
    if [ "${apps}" != "" ]; then
      while read -r app
      do
        icon_strip+="$($CONFIG_DIR/plugins/icon_map.sh "$app")"
      done <<< "${apps}"
    else
      icon_strip=" —"
    fi

    sketchybar --set space.$sid label="$icon_strip"
  done

  for i in $(aerospace list-workspaces --monitor $m --empty); do
    sketchybar --set space.$i display=0
  done
done

space_creator=(
  icon=􀆊
  icon.font="$FONT:Heavy:16.0"
  padding_left=0
  padding_right=0
  label.drawing=off
  display=active
  script="$PLUGIN_DIR/space_windows.sh"
  icon.color=$WHITE
)

sketchybar --add item space_creator left               \
           --set space_creator "${space_creator[@]}"   \
           --subscribe space_creator aerospace_workspace_change
