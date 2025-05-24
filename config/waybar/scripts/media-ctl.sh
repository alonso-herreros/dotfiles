#!/usr/bin/env bash

# Check for playerctl existence
if ! command -v playerctl >/dev/null; then
    echo "Couldn't find playerctl. Exiting."
    exit 1
fi


readonly CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/waybar/media-ctl"
readonly SHUFFLE_CACHE="$CACHE_DIR/shuffle_status"
readonly LOOP_CACHE="$CACHE_DIR/loop_status"
readonly VOLUME_CACHE="$CACHE_DIR/volume_status"
[[ -d "$CACHE_DIR" ]] || mkdir -p "$CACHE_DIR"


# ==== Functions ====

# ---- Shuffle ----

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


# ---- Loop ----

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


# ---- Volume ----

function set_volume() {
    local value="$1"

    # Set the volume using playerctl
    playerctl volume "$value" >/dev/null

    # Write the new volume to cache
    status=$(playerctl volume)
    write_cache "$VOLUME_CACHE" "$status"
}

function get_volume() {
    local volume=$(read_cache "$VOLUME_CACHE")

    [[ -z "$volume" && "$1" != "--cache-only" ]] && volume=$(playerctl volume)

    [[ -z "$volume" ]] && return 1

    volume_percent=$(awk '{print int($1*100 + 0.5)}' <(echo $volume) )

    echo "($volume_percent%)"
}


# ---- Lib functions ----

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
    volume )
        case "$2" in
            get | '' ) get_volume "$3";;
            * )  set_volume "$2";;
        esac;;
esac
