#!/usr/bin/env bash

# media-ctl.sh - A script to control media playback using playerctl
~/.config/waybar/scripts/media-ctl.sh volume "$@"
pkill -RTMIN+10 waybar
sleep 2.2
pkill -RTMIN+10 waybar
