#!/usr/bin/env bash

USAGE="
Usage: $0 [-e | -d] [-q] [-a]
       $0 -h

    -e, --enable    Enable kitty alt font features
    -d, --disable   Disable kitty alt font features
    -q, --quiet     Avoid showing notifications
    -a, --all       Reload all instances
    -h, --help      Show this message
"

OPTSTRING="edqah"
OPTSTRING_LONG="enable,disable,quiet,all,help"

function Help() {
    echo "$USAGE"
}

function send_notification() {
  mode="$1"
  message="Kitty alt font features: $mode"
  notify-send "$message" "" -i "$icon" -t 2000 -r 2593 -u low
}

# ==== Specifics ====

# This is where the kitty config is stored by default
KITTY_CONF_DIR="$HOME/.config/kitty"
KITTY_CONF_FILENAME="kitty.conf"
KITTY_CONF_PATH="$KITTY_CONF_DIR/$KITTY_CONF_FILENAME"
# IMPORTANT: This is a filename that will get included, specified in my kitty
# config.
DROP_IN_FILENAME="font_overrides.d.conf"
DROP_IN_PATH="$KITTY_CONF_DIR/$DROP_IN_FILENAME"

set_features() {
    if [[ "$1" = "on" ]]; then
        # Add a drop-in config file with alt font features
        awk '
        /^font_features/ { in_block=1 }
        in_block {
            print
            if ($0 ~ /^[[:space:]]*$/) {
                in_block=0
                print ""
            }
        }
        ' $KITTY_CONF_PATH | sed 's/^#/ /' > $DROP_IN_PATH
    else
        # Clear all content in the drop-in config file
        echo "" > "$DROP_IN_PATH"
    fi
    
    if [[ "$2" = "all" ]]; then
        # Reload all kitty instances
        pkill -USR1 -u $USER kitty
    elif [[ "$2" -ne "none" ]]; then
        # Reload calling instance
        kitten @ load-config
        # Reset features for next instances without updating
        set_features off none
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
            -a | --all)
                all="all"
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
all="no"
quiet=0

# Parse args, setting options on the way
args "$0" "$@"

# Set power management mode
set_features "$mode" "$all"
# Send a notification aobut the change if not on quiet mode
[[ $quiet -eq 0 ]] && send_notification "$mode"

