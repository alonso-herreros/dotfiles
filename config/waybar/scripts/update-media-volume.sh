#!/usr/bin/env bash

~/.scripts/system/media_ctl.sh volume "$@"
pkill -RTMIN+10 waybar
sleep 2.2
pkill -RTMIN+10 waybar
