#!/usr/bin/env zsh

# ZSH's history is different from bash, so here's my fucntion to remove the
# last item from history.

# This sub-function checks if the argument passed is a number.
is_int() {
    return $(test "$@" -eq "$@" > /dev/null 2>&1)
}

# Get history file's location
: ${HISTFILE:?} # Error if unset
history_temp_file="${HISTFILE}.tmp"

lines_to_remove="${1:-1}"
# Sanity check
if ! is_int "${lines_to_remove}"; then
    echo "Fatal: '${lines_to_remove}' is not a number" >&2
else
    fc -W # write current shell's history to the history file.

    # Get the files contents minus the last N entries (head -n -<N> does that)
    head -n "-${lines_to_remove}" ${HISTFILE} > ${history_temp_file} \
        && mv "${history_temp_file}" "${HISTFILE}"

    fc -R # read history file.
fi
