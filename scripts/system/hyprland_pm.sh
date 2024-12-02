#!/usr/bin/env bash

# Usage:
# $ ./hyprland_pm.sh -e
# $ ./hyprland_pm.sh -d

# readonly SCALES=(1.00 1.20 1.25 1.333333 1.40 1.50 1.60 1.666667 1.875 2.00)

send_notification() {
  mode="$1"

  message="Hyprland power saving: $mode"

  dunstify "$message" "" -i $icon -t 1500 -r 2593 -u low
}

# get_scale() {
#     hyprctl monitors -j | jq '.[].scale' # It works for now
# }

# get_scale_index() {
#     scale=$(get_scale)
#     for i in "${!SCALES[@]}"; do
#         [[ "${SCALES[$i]}" = "${scale}" ]] && scale_index="$i"
#     done
#     echo $scale_index
# }

set_pm() {
    case "$1" in
        on)
            hyprctl keyword decoration:inactive_opacity 1.0
            hyprctl keyword decoration:blur:enabled false
            hyprctl keyword decoration:shadow:enabled false

            hyprctl keyword misc:vfr true
            hyprctl keyword plugin:dynamic-cursors:enabled false

            hyprctl keyword windowrulev2 opacity 1.0 override,title:.*
            ;;
        off)
            hyprctl reload
            ;;
    esac
    send_notification "$1"
}

case "$1" in
    -e|--enable)
        set_pm on
        ;;
    -d|--disable)
        set_pm off
        ;;
    -h|--help)
        ;;
    *)
        ;;
esac

