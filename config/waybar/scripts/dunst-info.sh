#!/usr/bin/env bash

# Check for dunstctl existence
if ! command -v dunstctl >/dev/null; then
    echo "Fatal: Couldn't find dunstctl." >&2
    exit 1
fi

# ==== Usage ====
USAGE="
dunst-info - Print dunstctl info
Usage: $0 [OPTIONS] [PARAM]
       $0 -h

OPTIONS:

    -h, --help      Show this message
    -j, --json      Output JSON

PARAMS:

    pause           Show pause info
"

function Help() {
    echo "$USAGE"
}

# ==== Constants ====

# ==== Functions ====
ICON_BELL_SLASH=" " # 1x normal space " "
ICON_BELL="    " # 2x hair space " ", 2x thin space " "


function pause_info() {
    if [ "$(dunstctl is-paused)" == "true" ]; then
        status=paused
        icon="$ICON_BELL_SLASH"
    else
        status=unpaused
        icon="$ICON_BELL"
    fi
    pause_level="$(dunstctl get-pause-level)"

    if [ "$JSON" -eq 1 ]; then
        jq -n --unbuffered --compact-output \
            --arg text "$icon" \
            --arg status "$status" \
            --arg tooltip "Pause level: $pause_level" \
            '{
                "text": $text, "alt": $status,
                "tooltip": $tooltip, "class": $status
            }'
    else
        echo "$status"
    fi
}


# ==== Main ====

# ---- Globals ----
JSON=0


# ---- Args ----
case "$1" in
    -h | --help )
        Help
        exit 0;;
    -j | --json )
        JSON=1
        shift;;
esac

case "$1" in
    pause )
        pause_info
        ;;
esac
