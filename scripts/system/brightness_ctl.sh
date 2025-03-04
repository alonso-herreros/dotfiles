#!/usr/bin/env bash

# Usage:
# $ ./brightness_ctl.sh i 5
# $ ./volumeControl.sh d
# $ ./volumeControl.sh t

# Script modified from here:
# https://gist.github.com/Blaradox/030f06d165a82583ae817ee954438f2e

function send_notification {
  # icon="preferences-system-brightness-lock"
  icon="weather-clear" # Currently does nothing

  level=$(( $(brightnessctl g)*100/$(brightnessctl m) ))

  message="Brightness: $level %"

  notify-send "$message" "" \
    -i "$icon" \
    -t 1500 \
    -r 2593 \
    -u low \
    -h int:value:$level
}

brightnessctl $@

send_notification

