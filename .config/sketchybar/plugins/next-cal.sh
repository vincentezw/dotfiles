#!/bin/bash

event_info=$(osascript <<EOD
tell application "Calendar"
  set theEvents to summary of (every event of calendar "Home" whose start date is greater than (current date))
  if (count of theEvents) > 0 then
    set nextEvent to item 1 of theEvents
    set eventStartTime to start date of (first event of calendar "Home" whose summary is nextEvent)
    return nextEvent & "\n" & eventStartTime
  else
    return "none"
  end if
end tell
EOD
)

if [[ "$event_info" == "none" ]]; then
  sketchybar --set $NAME drawing=off
else
  event_title=$(echo "$event_info" | sed -n '1p')
  event_start_time=$(echo "$event_info" | sed -n '2p')

  current_time=$(date +%s)
  event_start_epoch=$(date -j -f "%A %d %B %Y at %H:%M:%S" "$event_start_time" +%s 2>/dev/null)
  time_diff=$((event_start_epoch - current_time))

  if [[ $time_diff -gt 0 ]]; then
    days=$((time_diff / 86400))
    remaining=$((time_diff % 86400))
    hours=$((remaining / 3600))
    remaining=$((remaining % 3600))
    minutes=$((remaining / 60))

    output="$event_title starts in "
    if [[ $days -gt 0 ]]; then
      output+="${days}d "
    fi
    if [[ $hours -gt 0 ]]; then
      output+="${hours}h "
    fi
    if [[ $minutes -gt 0 ]]; then
      output+="${minutes}m"
    fi

    echo $output
    sketchybar --set $NAME drawing=on label="$output"
  fi
fi

