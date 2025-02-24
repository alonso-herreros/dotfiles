#!/usr/bin/env sh

bt_status=$(bluetoothctl show | grep "Powered: yes")

if [ -n "$bt_status" ]; then
  bluetoothctl power off
else
  rfkill unblock bluetooth
  bluetoothctl power on
fi

