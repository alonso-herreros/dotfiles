#!/usr/bin/env bash

# =============== Help ===============
function Help() {
    cat << EOF
Display the current battery status with an icon and percentage.
Great for use in a status bar or lock screen.

Usage: display_battery.sh [OPTIONS]

Options:
  -s, --status <status>      Override the battery status (e.g., charging, full).
  -p, --percentage <value>   Override the battery percentage.
  -h, --help                 Show this help message and exit.
EOF
}

# =============== Constants ===============
readonly ICON_PROGRESSION=( "  " "  " "  " "  " "  " )
readonly ICON_COUNT=${#ICON_PROGRESSION[@]}
readonly ICON_CHARGE=" "

# =============== Get values ===============
battery_name=$(upower -e | grep -m 1 BAT)

battery_info="$(upower -i $battery_name)"
status="$(echo "$battery_info" | sed -En 's/^\s*state:\s*(.*)$/\1/p')"
percentage="$(echo "$battery_info" | sed -En 's/^\s*percentage:\s*(.*)%/\1/p')"

# =============== Parse arguments ===============
while [ "$#" -gt 0 ]; do
    case "$1" in
        -s | --status)
            status="$2"
            shift;;
        -p | --percentage)
            percentage="$2"
            shift;;
        -h | --help)
            Help
            exit 0;;
    esac
    shift
done

# =============== Determine icon ===============
case "$status" in
    charging ) icon=$ICON_CHARGE;;
    full ) icon=${ICON_PROGRESSION[$ICON_COUNT - 1]};;
esac

if [ -z "$icon" ]; then
    case "$((percentage / (100 / ICON_COUNT)))" in
        0) icon=${ICON_PROGRESSION[0]} ;;
        1) icon=${ICON_PROGRESSION[1]} ;;
        2) icon=${ICON_PROGRESSION[2]} ;;
        3) icon=${ICON_PROGRESSION[3]} ;;
        *) icon=${ICON_PROGRESSION[4]} ;;
    esac
fi

# =============== Output ===============
echo "$icon $percentage %"
