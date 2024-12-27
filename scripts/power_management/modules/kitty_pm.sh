#!/usr/bin/env bash

USAGE="
Usage: $0 [-e | -d] [-q]
       $0 -h

    -e, --enable    Enable kitty power saving options
    -d, --disable   Disable kitty power saving options
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
  message="Kitty power saving: $mode"
  notify-send "$message" "" -i "$icon" -t 2000 -r 2593 -u low
}

# ==== Specifics ====

# This is where the kitty config is stored by default
KITTY_CONF_DIR="$HOME/.config/kitty"
# IMPORTANT: This is a filename that will get included, specified in my kitty
# config.
DROP_IN_FILENAME="power_saving.d.conf"

# Options that should save some power
POWER_SAVING_OPTIONS="
background_opacity 1.0
"

set_pm() {
    if [[ "$1" = "on" ]]; then
        # Add a drop-in config file with power saving options
        echo $POWER_SAVING_OPTIONS > "$KITTY_CONF_DIR/$DROP_IN_FILENAME"
        pkill -USR1 -u $USER kitty
    else
        # Clear all content in the drop-in config file
        echo "" > "$KITTY_CONF_DIR/$DROP_IN_FILENAME"
        pkill -USR1 -u $USER kitty
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

