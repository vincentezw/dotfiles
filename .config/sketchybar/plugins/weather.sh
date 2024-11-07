sketchybar --set $NAME \
  label="Loading..." \
  icon.color=0xff5edaff

# fetch weather data

# Line below replaces spaces with +
WEATHER=$(curl -s "wttr.in/Portmagee?format=%25c+%25t" | sed 's/+//g' | tr -d ' ')

# Fallback if empty
if [ -z "$WEATHER" ]; then
  sketchybar --set $NAME label="Portmagee"
  return
fi

sketchybar --set $NAME \
  label="$WEATHER"
