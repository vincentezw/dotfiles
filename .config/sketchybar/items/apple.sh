#!/bin/bash

POPUP_OFF='sketchybar --set apple.logo popup.drawing=off'
POPUP_CLICK_SCRIPT='sketchybar --set $NAME popup.drawing=toggle'

apple_logo=(
  icon=$APPLE
  icon.font="$FONT:White:14.0"
  padding_left=0
  label.drawing=off
  click_script="$POPUP_CLICK_SCRIPT"
  popup.height=35
  popup.background.color=$BUBBLE_BG
  popup.background.border_color=$BUBBLE_ACTIVE_BG
  popup.background.border_width=2
  popup.background.corner_radius=7
  popup.blur_radius=5
  popup.y_offset=3
)

apple_prefs=(
  icon=$PREFERENCES
  label="Preferences"
  click_script="open -a 'System Preferences'; $POPUP_OFF"
  label.font="$FONT:$TEXT:12.0"
  label.padding_right=8
  icon.padding_left=5
  icon.padding_right=8
)

apple_activity=(
  icon=$ACTIVITY
  label="Activity"
  click_script="open -a 'Activity Monitor'; $POPUP_OFF"
  label.font="$FONT:$TEXT:12.0"
  label.padding_right=8
  icon.padding_left=5
  icon.padding_right=8
)

apple_lock=(
  icon=$LOCK
  label="Lock Screen"
  click_script="pmset displaysleepnow; $POPUP_OFF"
  label.font="$FONT:$TEXT:12.0"
  label.padding_right=8
  icon.padding_left=5
  icon.padding_right=8
)

sketchybar --add item apple.logo left                  \
           --set apple.logo "${apple_logo[@]}"         \
                                                       \
           --add item apple.prefs popup.apple.logo     \
           --set apple.prefs "${apple_prefs[@]}"       \
                                                       \
           --add item apple.activity popup.apple.logo  \
           --set apple.activity "${apple_activity[@]}" \
                                                       \
           --add item apple.lock popup.apple.logo      \
           --set apple.lock "${apple_lock[@]}"
