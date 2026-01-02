#!/usr/bin/env bash

USAGE="
Usage: $0 [-e | -d] [-q]
       $0 -h

    -e, --enable    Enable Hyprland power saving options
    -d, --disable   Disable Hyprland power saving options
    -q, --quiet     Avoid showing notifications
    -h, --help      Show this message
"

OPTSTRING="edqht"
OPTSTRING_LONG="enable,disable,quiet,help"

function Help() {
    echo "$USAGE"
}

function send_notification() {
  mode="$1"
  message="Hyprland power saving: $mode"
  notify-send "$message" "" -i "$icon" -t 3000 -r 2593 -u low
}

# This is where we'll save config to restore later
PERSISTENCE_DIR="$HOME/.cache/power_management/hyprland_pm/"
PERSISTENCE_FILENAME="variables"
PERSISTENCE_FILE="$PERSISTENCE_DIR/$PERSISTENCE_FILENAME"

# ==== Specifics ====

declare -A VARS_SAVING
VARS_SAVING=(
    ["decoration:inactive_opacity"]="1.0"
    ["decoration:blur:enabled"]="false"
    ["decoration:shadow:enabled"]="false"
    ["group:groupbar:blur"]="false"
    ["misc:vfr"]="true"
)
# Default values SHOULD be saved before enabling power management options and
# then loaded in order to restore true defaults. Otherwise, the whole hyprland
# config may need to be reloaded.

KEYWORDS_SAVING=(
    "plugin:dynamic-cursors:enabled false"
    "windowrulev2 opacity 1.0 override, initialClass:.*"
)
KEYWORDS_DEFAULT=(
    "plugin:dynamic-cursors:enabled true"
    "windowrulev2 unset, initialClass:.*"
)

save_vars() {
    declare -A VARS_DEFAULT

    for k in "${!VARS_SAVING[@]}"; do
        VARS_DEFAULT[$k]=$(hyprctl getoption $k | head -n 1 | cut -d " " -f 2)
    done

    mkdir -p $PERSISTENCE_DIR
    declare -p VARS_DEFAULT > $PERSISTENCE_FILE
}

set_pm() {
    case "$1" in
        on)
            for key in "${!VARS_SAVING[@]}"; do
                hyprctl keyword $key ${VARS_SAVING[$key]}
            done

            for val in "${KEYWORDS_SAVING[@]}"; do
                hyprctl keyword $val
            done
            ;;
        off)
            source "$PERSISTENCE_FILE" &>/dev/null
            if [[ ${#VARS_DEFAULT[@]} -le 0 ]]; then
                hyprctl reload
                return
            fi

            for key in "${!VARS_DEFAULT[@]}"; do
                hyprctl keyword $key ${VARS_DEFAULT[$key]}
            done

            for val in "${KEYWORDS_DEFAULT[@]}"; do
                hyprctl keyword $val
            done
            ;;
    esac
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
            -t)
                save_vars
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

# Save variables if possible
[[ $mode = "on" ]] && save_vars
# Set power management mode
set_pm "$mode"
# Send a notification aobut the change if not on quiet mode
[[ $quiet -eq 0 ]] && send_notification "$mode"

