#!/bin/bash

WIDTH=100
BUBBLE_BG=0xaa95ada3
BUBBLE_ACTIVE_BG=0xaa399999
TEXT=0xfffafbfb
FONT="VictorMono Nerd Font"

detail_on() {
  sketchybar --animate tanh 30 --set volume slider.width=$WIDTH
}

detail_off() {
  sketchybar --animate tanh 30 --set volume slider.width=0
}

toggle_detail() {
  INITIAL_WIDTH=$(sketchybar --query volume | jq -r ".slider.width")
  if [ "$INITIAL_WIDTH" -eq "0" ]; then
    detail_on
  else
    detail_off
  fi
}

toggle_devices() {
  which SwitchAudioSource >/dev/null || exit 0

  args=(--remove '/volume.device\.*/' --set "$NAME" popup.drawing=toggle)
  COUNTER=0
  CURRENT="$(SwitchAudioSource -t output -c)"
  while IFS= read -r device; do
    COLOR=$BUBBLE_BG
    if [ "${device}" = "$CURRENT" ]; then
      COLOR=$BUBBLE_ACTIVE_BG
    fi
    args+=(--add item volume.device.$COUNTER popup."$NAME" \
           --set volume.device.$COUNTER label="${device}" \
                                        label.font="$FONT:$TEXT:12.0" \
                                        label.padding_right=8 \
                                        icon.padding_left=5 \
                                        icon.padding_right=8 \
                                        background.color="$COLOR" \
                   click_script="SwitchAudioSource -s \"${device}\" && sketchybar --set /volume.device\.*/ label.color=$GREY --set \$NAME label.color=$WHITE --set $NAME popup.drawing=off")
      COUNTER=$((COUNTER+1))
    done <<< "$(SwitchAudioSource -a -t output)"

    sketchybar -m "${args[@]}" > /dev/null
  }

  if [ "$BUTTON" = "right" ] || [ "$MODIFIER" = "shift" ]; then
    toggle_devices
  else
    toggle_detail
fi
