#!/usr/bin/env bash

# Usage:
# $ ./hyprland_scale.sh i 5
# $ ./hyprland_scale.sh d

readonly SCALES=(1.00 1.20 1.25 1.333333 1.40 1.50 1.60 1.666667 1.875 2.00)

send_notification() {
  scale=$(get_scale)

  message="Monitor scale: $scale"

  dunstify "$message" "" -i $icon -t 1500 -r 2593 -u low
}

get_scale() {
    hyprctl monitors -j | jq '.[].scale' # It works for now
}

get_scale_index() {
    scale=$(get_scale)
    for i in "${!SCALES[@]}"; do
        [[ "${SCALES[$i]}" = "${scale}" ]] && scale_index="$i"
    done
    echo $scale_index
}

set_scale() {
    hyprctl keyword monitor ,preferred,auto,$1
    echo "Monitor scale set to $1"

}

case "$1" in
    -s)
        shift
        set_scale "$1"
        ;;
    -i)
        set_scale "${SCALES[$(get_scale_index)+1]}"
        ;;
    -d)
        set_scale "${SCALES[$(get_scale_index)-1]}"
        ;;
    *)
        echo "Monitor scale is $(get_scale)"
        ;;
esac

send_notification

