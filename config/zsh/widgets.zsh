#!/usr/bin/env sed -n '2,5s/^#\s\?//p'
# This is not meant to be executed, but sourced within your ZSH init scripts.
# Try adding the following to your .zshrc:
#
#     . <this file>

# ===== Helpers =====
msg() {
	zle -M "$@" 2>/dev/null || echo "$@" >&2
}


# ===== ZSH widgets =====

history-forget() {
	history_temp_file="${HISTFILE:?}.tmp" # Error if HISTFILE unset

	lines_to_remove="${1:-1}"
	if ! [ "${lines_to_remove}" -eq "${lines_to_remove}" ] 2>/dev/null; then
		msg "fatal: '${lines_to_remove}' is not a number"
		return 1
	fi

	fc -W # write current shell's history to the history file.

	# Get the files contents minus the last N entries (head -n -<N> does that)
	head -n "-${lines_to_remove}" ${HISTFILE} > ${history_temp_file} \
		&& mv -f "${history_temp_file}" "${HISTFILE}" \
		&& rm -f "${history_temp_file}"

	fc -R # read history file.

	msg "Removed last ${n_to_remove} entries from history."
}

zle -N history-forget
