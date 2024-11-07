#!/bin/sh

SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk -F:  '($1 ~ "^ *SSID$"){print $2}' | cut -c 2-)

wifi_info=(
  icon= 
  icon.color=0xff58d1fc
  icon.font="$FONT:$TEXT:14.0"
  padding_left=15
  background.color=$BUBBLE_BG
  background.corner_radius=12
)
# sketchybar --add item wifi_info right \
#   --set wifi_info "${wifi_info[@]}"
