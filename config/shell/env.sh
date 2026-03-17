#!/bin/sed 4,6!d;s/#.//
# Common environment variables.
#
# This script is meant to be sourced from within a shell, not executed. Try:
#
#     . ~/.config/shell/env.sh


# ===== Options ============================================
export LANG=en_US.utf8


# ===== Paths ==============================================
# ----- Search paths -----------------------------
# An include guard, since this is technically not idempotent
if [ -z "$INCLUDED_ENV_PATHS" ]; then
    INCLUDED_ENV_PATHS=1
    [ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
    [ -d "$HOME/.local/lib/locale" ] && export LOCPATH="$HOME/.local/lib/locale:$LOCPATH"
fi

# ----- XDG --------------------------------------
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_DATA_HOME" ]   && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_STATE_HOME" ]  && export XDG_STATE_HOME="$HOME/.local/state"
[ -z "$XDG_CACHE_HOME" ]  && export XDG_CACHE_HOME="$HOME/.cache"

export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock


# ===== Programs and options ===============================
if command -v vim >/dev/null 2>&1; then
    export EDITOR="vim"
fi

if command -v less >/dev/null 2>&1; then
    export PAGER="less"
    export LESS="-Ri"
    export LESSHISTFILE="$XDG_STATE_HOME/less/history"
fi

if command -v ghdl >/dev/null 2>&1; then
    export GHDL="$(command -v ghdl)"
fi

if command -v screen >/dev/null 2>&1; then
    export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
    export SCREENDIR="$XDG_RUNTIME_DIR/screen"
fi


# ===== Default user and hostname ==========================
# We need to check if the variable is set to avoid overriding it
[ -z "$DEFAULT_USER" ] && export DEFAULT_USER="$(whoami)"
[ -z "$DEFAULT_HOSTNAME" ] && export DEFAULT_HOSTNAME="$(hostname)"
