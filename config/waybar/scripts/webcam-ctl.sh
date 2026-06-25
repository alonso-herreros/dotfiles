#!/usr/bin/env bash

# Check for jq existence
if ! command -v jq >/dev/null; then
    echo "Fatal: Couldn't find jq." >&2
    exit 1
fi

# ==== Usage ====
USAGE="
webcam-ctl - Check/control webcam (uvcvideo) state
Usage: $0 [OPTIONS] [PARAM]
       $0 -h

OPTIONS:

    -h, --help      Show this message
    -j, --json      Output JSON

PARAMS:

    status          Show webcam state / use count
    count           Show webcam use count
    enable          Enable webcam (modprobe uvcvideo)
    disable         Disable webcam (rmmod uvcvideo, refuses if in use)
    toggle          Toggle webcam state
"

function Help() {
    echo "$USAGE"
}

# ==== Constants ====
MODULE=uvcvideo

ICON_CAM_OFF="󰗟 "   # Disabled (module unloaded)
ICON_CAM_ON="󰄀 "    # Enabled, idle
ICON_CAM_BUSY="󰄀 "  # Enabled, in use

# ==== Functions ====

function is_loaded() {
    [ -d "/sys/module/$MODULE" ]
}

function get_refcnt() {
    if is_loaded; then
        cat "/sys/module/$MODULE/refcnt" 2>/dev/null || echo 0
    else
        echo 0
    fi
}

function status_info() {
    local refcnt
    refcnt="$(get_refcnt)"

    if ! is_loaded; then
        status=disabled
        icon="$ICON_CAM_OFF"
    elif [ "$refcnt" -gt 0 ]; then
        status=active
        icon="$ICON_CAM_BUSY"
    else
        status=enabled
        icon="$ICON_CAM_ON"
    fi

    if [ "$JSON" -eq 1 ]; then
        jq -n --unbuffered --compact-output \
            --arg text "$icon" \
            --arg status "$status" \
            --arg tooltip "Webcam: $status (in use by $refcnt)" \
            '{
                "text": $text, "alt": $status,
                "tooltip": $tooltip, "class": $status
            }'
    else
        echo "$status ($refcnt)"
    fi
}

function count_info() {
    local refcnt
    refcnt="$(get_refcnt)"

    if [ "$JSON" -eq 1 ]; then
        jq -n --unbuffered --compact-output \
            --arg text "$refcnt" \
            --arg status "$status" \
            --arg tooltip "Webcam: $status (in use by $refcnt)" \
            '{
                "text": $text, "alt": $status,
                "tooltip": $tooltip, "class": $status
            }'
    else
        echo "$status ($refcnt)"
    fi
}

function enable_webcam() {
    if is_loaded; then
        exit 0
    fi
    pkexec modprobe "$MODULE"
}

function disable_webcam() {
    if ! is_loaded; then
        exit 0
    fi

    local refcnt
    refcnt="$(get_refcnt)"
    if [ "$refcnt" -gt 0 ]; then
        echo "Webcam in use by $refcnt process(es). Can't disable." >&2
        command -v notify-send >/dev/null && \
            notify-send -u normal "Webcam" "In use by $refcnt process(es). Can't disable."
        exit 1
    fi

    pkexec modprobe -r "$MODULE"
}

function toggle_webcam() {
    if is_loaded; then
        disable_webcam
    else
        enable_webcam
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
    status )
        status_info
        ;;
    count )
        count_info
        ;;
    enable )
        enable_webcam
        ;;
    disable )
        disable_webcam
        ;;
    toggle )
        toggle_webcam
        ;;
    * )
        Help
        exit 1
        ;;
esac
