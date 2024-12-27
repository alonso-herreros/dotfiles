#!/usr/bin/env bash

USAGE="
Usage: $0 [-e | -d] [-q]
       $0 -h

    -e, --enable    Enable power saving modules
    -d, --disable   Disable power saving modules
    -q, --quiet     Avoid printing information and showing notifications
    -h, --help      Show this message
"

OPTSTRING="edqh"
OPTSTRING_LONG="enable,disable,quiet,help"

function Help() {
    echo "$USAGE"
}

function send_notification() {
  mode="$1"
  message="Power saving: $mode"
  notify-send "$message" "" -i "$icon" -t 3000 -r 2593 -u low
}

# ==== Specifics ====

function set_pm() {
    [[ "$1" == "on" ]] && options="-e" || options="-d"
    options="$options -q"

    for module in modules/*; do
        $module $options
    done
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

