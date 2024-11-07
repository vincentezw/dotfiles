#!/bin/bash

cd ./plugins/spotify && PLAYING=$(ruby spotify.rb)

if [ -z "$PLAYING" ] || [ "$PLAYING" = "NONE" ]; then
  sketchybar --set $NAME drawing=off
else
  sketchybar --set $NAME drawing=on label="$PLAYING"
fi
