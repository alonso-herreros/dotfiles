#!/usr/bin/env bash

USAGE="
Usage: $0 [-e | -d] [-q]
       $0 -h

    -e, --enable    Enable dusnt power saving options
    -d, --disable   Disable dusnt power saving options
    -q, --quiet     Avoid showing notifications
    -h, --help      Show this message
"

OPTSTRING="edqh"
OPTSTRING_LONG="enable,disable,quiet,help"

function Help() {
    echo "$USAGE"
}

function send_notification() {
  mode="$1"
  message="Dusnt power saving: $mode"
  notify-send "$message" "" -i "$icon" -t 2000 -r 2593 -u low
}

# ==== Specifics ====

# This is where the dunst config is stored by default
DUNST_CONF_DIR="$HOME/.config/dunst"
# Dunst loads all .conf files in this directory
DUNST_DROP_IN_DIR="$DUNST_CONF_DIR/dunstrc.d"
# IMPORTANT: The leading 9 indicates this should be loaded last. All other
# files in the drop-in directory should have leading numbers lower than 9.
FILE_NAME="9-power_saving.conf"

set_pm() {
    if [[ "$1" = "on" ]]; then
        # Get current background color without alpha
        bg_color="$(\rg 'background\s*=\s*"#([\da-f]{6})[\da-f]{2}?"' -iINor '$1' $DUNST_CONF_DIR)"

        # Build contents of drop-in file
        power_saving_options="[global]

        background = \"#$bg_color\"
        "

        echo "$power_saving_options" > "$DUNST_DROP_IN_DIR/$FILE_NAME"
        dunstctl reload
    else
        # Clear all content in the drop-in config file
        echo "" > "$DUNST_DROP_IN_DIR/$FILE_NAME"
        dunstctl reload
    fi
}

# ==== Argument parsing ====

function args() {
    local options=$(getopt -o "$OPTSTRING" --long "$OPTSTRING_LONG" -- "$@")
    eval set -- "$options"

    while true; do
        case "$1" in
            -e | --enable)
                mode=on
                shift
                ;;
            -d | --disable)
                mode=off
                shift
                ;;
            -q | --quiet)
                quiet=1
                shift
                ;;
            -h | --help)
                Help
                exit 0
                ;;
            --)
                shift
                break;;
        esac
    done
}

# ==== Main flow ====

# Default options
mode="on"
quiet=0

# Parse args, setting options on the way
args "$0" "$@"

# Set power management mode
set_pm "$mode"
# Send a notification aobut the change if not on quiet mode
[[ $quiet -eq 0 ]] && send_notification "$mode"

