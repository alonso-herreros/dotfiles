#!/usr/bin/env sh

USAGE="
Usage: $0 DISPATCHER
       $0 -h

Run a hyprctl dispatcher using the secondary workspace based on active
workspace ID ({current}1), or the primary if the secondary is active.

ARGUMENTS:
    DISPATCHER      The dispatcher to run

OPTIONS:
    -h, --help      Show this message
"

function Help() {
    echo "$USAGE"
}

# ==== Specifics ====

function toggle_secondary_id() {
    active_id=$(hyprctl activeworkspace -j | jq '.["id"]')
    echo $active_id | sed 's/^\(.\+\)1$/\1/; t; s/$/1/'
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

# Parse arguments
args "$@"

# Sets secondary_name
target_id=$(toggle_secondary_id)

# Execute dispatcher with proper parameters
hyprctl dispatch $1 $target_id
