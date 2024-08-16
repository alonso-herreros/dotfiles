#!/usr/bin/env sh

wifi_status=$(nmcli radio wifi)

if [ "$wifi_status" = "enabled" ]; then
    nmcli radio wifi off
else
    nmcli radio wifi on
fi

