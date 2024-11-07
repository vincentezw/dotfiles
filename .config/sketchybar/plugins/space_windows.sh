#!/usr/bin/env bash
 
# echo AEROSPACE_PREV_WORKSPACE: $AEROSPACE_PREV_WORKSPACE, \
#  AEROSPACE_FOCUSED_WORKSPACE: $AEROSPACE_FOCUSED_WORKSPACE \
#  SELECTED: $SELECTED \
#  BG2: $BG2 \
#  INFO: $INFO \
#  SENDER: $SENDER \
#  NAME: $NAME \

AEROSPACE_FOCUSED_MONITOR=$(aerospace list-monitors --focused | awk '{print $1}')
AEROSAPCE_WORKSPACE_FOCUSED_MONITOR=$(aerospace list-workspaces --monitor focused --empty no)
AEROSPACE_EMPTY_WORKESPACE=$(aerospace list-workspaces --monitor focused --empty)

BUBBLE_BG=0xaa95ada3
BUBBLE_ACTIVE_BG=0xaa399999
DARK=0xcc232323

reload_workspace_icon() {
  # echo reload_workspace_icon "$@" >> ~/aaaa
  apps=$(aerospace list-windows --workspace "$@" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app
    do
      icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
    done <<< "${apps}"
  else
    icon_strip=" —"
  fi

  sketchybar --animate sin 10 --set space.$@ label="$icon_strip"
}

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  reload_workspace_icon "$AEROSPACE_PREV_WORKSPACE"
  reload_workspace_icon "$AEROSPACE_FOCUSED_WORKSPACE"

  # current workspace space background colour
  sketchybar --set space.$AEROSPACE_FOCUSED_WORKSPACE background.color=$BUBBLE_ACTIVE_BG

  # prev workspace space background colour
  sketchybar --set space.$AEROSPACE_PREV_WORKSPACE background.color=$DARK

  for i in $AEROSAPCE_WORKSPACE_FOCUSED_MONITOR; do
    sketchybar --set space.$i display=$AEROSPACE_FOCUSED_MONITOR
  done

  for i in $AEROSPACE_EMPTY_WORKESPACE; do
    sketchybar --set space.$i display=0
  done

  sketchybar --set space.$AEROSPACE_FOCUSED_WORKSPACE display=$AEROSPACE_FOCUSED_MONITOR
fi
