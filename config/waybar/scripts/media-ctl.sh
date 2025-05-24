#!/usr/bin/env bash

# Check for playerctl existence
if ! command -v playerctl >/dev/null; then
    echo "Couldn't find playerctl. Exiting."
    exit 1
fi


readonly CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/waybar/media-ctl"
readonly SHUFFLE_CACHE="$CACHE_DIR/shuffle_status"
readonly LOOP_CACHE="$CACHE_DIR/loop_status"
[[ -d "$CACHE_DIR" ]] || mkdir -p "$CACHE_DIR"

readonly LOOP_MODES=("None" "Track" "Playlist")


function set_shuffle() {
    local shuffle_op="$1"
    local status="$(get_shuffle -q)"

    playerctl shuffle "$shuffle_op" >/dev/null

    # Calculate the new shuffle status manually to cache it
    if [[ "$shuffle_op" == "Toggle" ]]; then
        [[ "$status" == "On" ]] && status="Off" || status="On"
    else
        status="$shuffle_op"
    fi

    write_cache "$SHUFFLE_CACHE" "$status"
}

function get_shuffle() {
    local status=$(read_cache "$SHUFFLE_CACHE" || playerctl shuffle)

    print_status "Shuffle" "$status" "$1"
}


function set_loop() {
    local loop_op="$1"
    local status="$(get_loop -q)"

    if [[ "$loop_op" == "Cycle" ]]; then
        # Cycle through the loop modes: Off, Track, Playlist
        case "$status" in
            None ) loop_op="Playlist";;
            Playlist ) loop_op="Track";;
            Track ) loop_op="None";;
        esac
    fi

    playerctl loop "$loop_op" >/dev/null

    # Calculate the new shuffle status manually to cache it
    status="$loop_op"

    write_cache "$LOOP_CACHE" "$status"
}

function get_loop() {
    local status=$(read_cache "$LOOP_CACHE" || playerctl loop)

    print_status "Loop" "$status" "$1"
}


function read_cache() {
    local cache_file="$1"
    local valid_time="${2:-2000}"
    local read_value=

    if [[ -r "$cache_file" ]]; then
        last_update_time=$(head -n1 "$cache_file")
        current_time=$(date +%s%3N) # Time in milliseconds
        if (( current_time - last_update_time < valid_time )); then
            read_value=$(tail -n1 "$cache_file")
            echo "$read_value" && return 0
        else
            rm "$cache_file" 2>/dev/null
        fi
    fi

    return 1
}

function write_cache() {
    local cache_file="$1"
    local write_value="$2"

    date +%s%3N > "$cache_file" # Time in milliseconds
    echo "$write_value" >> "$cache_file"
}


function print_status() {
    local param="$1"
    local status="$2"

    case "$3" in
        --json )
            jq -n --unbuffered --compact-output \
                --arg status "$status" \
                --arg tooltip "$param: $status" \
                '{
                    "text": $status, "alt": $status,
                    "tooltip": $tooltip, "class": $status
                }'
            ;;
        -v | --verbose )
            echo "$status"
            echo "$param: $status"
            echo "$status"
            ;;
        * )
            echo "$status";;
    esac
}


# ==== Main ====

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <command> [<arg>]"
    echo "Commands:"
    echo "  shuffle [on|off|toggle] - Get or set shuffle status"
    echo "  loop [None|Track|Playlist|Cycle] - Get or set loop mode"
    echo "  volume [0-100] - Get or set volume level"
    exit 1
fi

case "$1" in
    shuffle )
        case "$2" in
            get | '' ) get_shuffle "$3";;
            * )  set_shuffle "$2";;
        esac;;
    loop )
        case "$2" in
            get | '' ) get_loop "$3";;
            * )  set_loop "$2";;
        esac;;
esac
