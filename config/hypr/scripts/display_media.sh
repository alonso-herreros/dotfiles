#!/usr/bin/env bash

# =============== Help ===============
Help() {
    cat << EOF
Display the current playing media information.
Great for use in a status bar or lock screen.

Usage: display_battery.sh [OPTIONS]

Options:
  -s, --status <status>      Override the player status (e.g., paused, playing).
  -p, --player <name>        Override the player name.
  -i, --info <string>        Override the info displayed
  -h, --help                 Show this help message and exit.
EOF
}

# =============== Constants ===============
readonly ICON_PLAYING=" "
readonly ICON_PAUSED=" "
readonly ICON_STOPPED=" "

readonly ICON_SPOTIFY=" "

# =============== Parse arguments ===============
while [ "$#" -gt 0 ]; do
    case "$1" in
        -s | --status)
            status="$2"
            shift;;
        -p | --player)
            player="$2"
            shift;;
        -i | --info)
            info="$2"
            shift;;
        -h | --help)
            Help
            exit 0;;
    esac
    shift
done

# =============== Get values ===============
: ${status=$(playerctl status)}
: ${info=$(playerctl metadata -f '{{title}} - {{artist}}' 2>/dev/null)}
: ${player=$(playerctl status -f '{{playerName}}' 2>/dev/null)}

# =============== Determine icon and text ===============
case "$status" in
    Playing )
        case "$player" in
            spotify ) icon=$ICON_SPOTIFY ;;
            * ) icon=$ICON_PLAYING ;;
        esac
        text="<i>$info</i>"
        ;;
    Paused )
        icon=$ICON_PAUSED
        case "$player" in
            spotify ) text="$info" ;;
        esac
        ;;
    Stopped )
        icon=$ICON_STOPPED
        ;;
esac

# =============== Output ===============
echo "$icon $text"
