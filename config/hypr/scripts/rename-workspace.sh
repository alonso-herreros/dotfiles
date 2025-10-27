#!/usr/bin/env sh

USAGE="
Rename a workspace, maybe interactively.
Usage: $0 [options] [NAME]
       $0 -h

POSITIONAL ARGUMENTS:
    NAME            The name to set the workspace to. Not required in
                    interactive mode, but can be used to pre-fill the input
                    prompt.

OPTIONS:
    -i, --interactive
                    Prompt for the new name using fuzzel
    -w, --workspace ID
                    Target workspace (default: active)
    -h, --help      Show this message
"

function Help() {
    echo "$USAGE"
}

# ==== Specifics ====

function get_active_id() {
    hyprctl activeworkspace -j | jq '.["id"]'
}

function get_workspace_name() {
    local id=$1
    hyprctl workspaces -j | jq -r ".[] | select(.id == $id) | .name"
}

# ==== Argument parsing ====

function args() {
    local positional=0
    while [ $# -gt 0 ]; do
        case "$1" in
            -i | --interactive)
                INTERACTIVE=1;;
            -w | --workspace)
                TARGET_ID="$2"
                shift;;
            -h | --help)
                Help
                exit 0;;
            *) # Positional parameter (there's only one)
                NAME="$1";;
        esac
        shift
    done
}

# ==== Main flow ====

# Initialize variables
INTERACTIVE=0
TARGET_ID=
NAME=

# Parse arguments
args "$@"

# Validate args
if [ $INTERACTIVE -eq 0 ] && [ -z "$NAME" ]; then
    echo "Error: You must provide a NAME or use --interactive mode." >&2
    Help
    exit 1
fi

# Defaults
TARGET_ID=${TARGET_ID:-$(get_active_id)}
NAME=${NAME:-$(get_workspace_name $TARGET_ID)}

# Process interactive mode
if [ "$INTERACTIVE" -eq 1 ]; then
    name_in=$( \
        fuzzel -d \
            --anchor top \
            --prompt-only="Rename Workspace: " \
            --placeholder="$TARGET_ID" \
            --search="$NAME" \
        )
    # If input is empty (user deleted the pre-filled name), reset name to ID
    NAME=${name_in:-$TARGET_ID}
fi

# Execute dispatcher with proper parameters
hyprctl dispatch renameworkspace $TARGET_ID ${NAME:-$TARGET_ID}
