#!/usr/bin/env sh

USAGE="
Usage: $0 DISPATCHER
       $0 -h

Run a hyprland dispatcher using the special workspace named 1s-10s based on
active workspace ID.

ARGUMENTS:
    DISPATCHER      The dispatcher to run

OPTIONS:
    -h, --help      Show this message
"

function Help() {
    echo "$USAGE"
}

# ==== Specifics ====

function get_special_name_auto() {
    active_workspace_id=$(hyprctl activeworkspace -j | jq '.["id"]')
    special_name="${active_workspace_id}s"
}

# ==== Argument parsing ====

function args() {
    case "$1" in
        -h | --help)
            Help
            exit 0;;
    esac
}

# ==== Main flow ====

# Options and defaults
special_name=tmp

# Parse arguments
args "$@"

# Sets special_name
get_special_name_auto

# Execute dispatcher with proper parameters
case "$1" in
    toggle* )
        hyprctl dispatch togglespecialworkspace $special_name
        ;;
    * )
        hyprctl dispatch $1 special:$special_name
        ;;
esac
