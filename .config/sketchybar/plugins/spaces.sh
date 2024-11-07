#!/bin/bash

update() {
  if [ "$SENDER" = "space_change" ]; then
    DARK=0xcc232323
    BUBBLE_BG=0xaa95ada3
    BUBBLE_ACTIVE_BG=0xaa399999

    if [ "$SELECTED" = true ]; then
      BACKGROUND=$BUBBLE_ACTIVE_BG
    else
      BACKGROUND=$DARK
    fi
    
    sketchybar --set "$NAME" background.color="$BACKGROUND"
  fi
}

set_space_label() {
  sketchybar --set $NAME icon="$@"
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    echo ''
  else
    if [ "$MODIFIER" = "shift" ]; then
      SPACE_LABEL="$(osascript -e "return (text returned of (display dialog \"Give a name to space $NAME:\" default answer \"\" with icon note buttons {\"Cancel\", \"Continue\"} default button \"Continue\"))")"
      if [ $? -eq 0 ]; then
        if [ "$SPACE_LABEL" = "" ]; then
          set_space_label "${NAME:6}"
        else
          set_space_label "${NAME:6} ($SPACE_LABEL)"
        fi
      fi
    else
      aerospace workspace ${NAME#*.}
    fi
  fi
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac
