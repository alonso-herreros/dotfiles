#!/usr/bin/env bash

# Usage:
# $ ./volumeControl.sh i 5
# $ ./volumeControl.sh d
# $ ./volumeControl.sh t

# Script modified from here:
# https://gist.github.com/Blaradox/030f06d165a82583ae817ee954438f2e

function send_notification {
  icon="audio-volume-high"

  volume=$(pamixer --get-volume)

  if [ $(pamixer --get-mute) = "true" ]; then
     icon="audio-volume-muted"
     muteText=" (Muted)"
  fi

  message="Volume$muteText: $volume %"

  dunstify "$message" -i $icon -t 1500 -r 2593 -u low -h int:value:$volume
}

pamixer $@

send_notification

