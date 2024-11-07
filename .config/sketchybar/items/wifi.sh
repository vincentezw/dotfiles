#!/bin/sh

# INFO="$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}' | xargs networksetup -getairportnetwork | sed "s/Current Wi-Fi Network: //")"
# SSID="$(system_profiler SPAirPortDataType | awk '/Current Network/ {getline;$1=$1;print $0 | "tr -d ':'";exit}')"
SSID="$(ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}')"

wifi_info=(
  background.color=$DARK
  # background.color=0xff232323
  background.corner_radius=12
  background.height=20
  icon.font="$FONT:$TEXT:12.0"
  icon.padding_left=12
  icon.padding_right=3
  icon= 
  label.font="$FONT:$TEXT:12.0"
  label.padding_right=12
  label=$SSID
  padding_left=0
  padding_right=0
)
sketchybar --add item wifi_info right \
  --set wifi_info "${wifi_info[@]}"
