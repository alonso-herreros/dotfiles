#!/usr/bin/env sh

USAGE="
Usage: $0 DISPATCHER
       $0 -h

Run a hyprctl dispatcher using the secondary workspace based on active
workspace ID ({current}1).

ARGUMENTS:
    DISPATCHER      The dispatcher to run

OPTIONS:
    -h, --help      Show this message
"

function Help() {
    echo "$USAGE"
}

# ==== Specifics ====

function get_secondary_id() {
    active_id=$(hyprctl activeworkspace -j | jq '.["id"]')
    secondary_id="$(echo $active_id | sed -e 's/^\(.\+\)1$/\1/')1"
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
get_secondary_id

# Execute dispatcher with proper parameters
hyprctl dispatch $1 $secondary_id
