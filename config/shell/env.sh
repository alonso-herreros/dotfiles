#!/bin/sed 4,6!d;s/#.//
# Common environment variables.
#
# This script is meant to be sourced from within a shell, not executed. Try:
#
#     . ~/.config/shell/env.sh

# ===== Helper function ====================================

# ----- Path manipulation ------------------------
# Remove a segment from a path
path_remove() { val="${1?}"; segment="${2?}"; var="${3:-REPLY}"
    case "$val" in
        *:$segment:* ) val="${val%%:$segment:*}:${val#*:$segment:}" ;;
        $segment:* )   val="${val#$segment:}" ;;
        *:$segment )   val="${val%:$segment}" ;;
        $segment )     val="" ;;
    esac
    eval "$var=\"\$val\""
}
# Add a segment to the path variable given, without duplicates
path_add() {
    mode=insert; export=0 # Defaults
    while [ "$#" -gt 0 ]; do case "$1" in # Arg parse
        -a | --append ) mode=append;;
        -i | --insert ) mode=insert;;
        -e | --export ) export=1;;
        -- ) shift; break;;
        * ) break;;
    esac; shift; done
    val="${1?}"; segment="${2?}"; var="${3}"

    [ -d "$segment" ] || return 1 # Dir existence check
    # If val starts with '$', expand the variable and set it as default for var
    case "$val" in *:*) ;; '$'*)
        var="${var:-${val#$}}"
        eval "val=\"$val\""
    ;; esac
    var="${var:-REPLY}" # var fallback

    path_remove "$val" "$segment" "$var" # Avoid duplicates
    case "$mode" in
        append) eval "$var=\"\${$var:+\$$var:}\$segment\"";;
        insert) eval "$var=\"\$segment\${$var:+:\$$var}\"";;
    esac
    [ "${export:-0}" -eq 1 ] && eval "export $var" || :
}


# ===== Options ============================================
export LANG=en_US.utf8


# ===== Paths ==============================================
# ----- Search paths -----------------------------
path_add -i -e '$PATH' "$HOME/.local/bin"
path_add -i -e '$LOCPATH' "$HOME/.local/lib/locale"

# ----- XDG Base Directories ---------------------
# Ideally, we wouldn't need any of this
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_DATA_HOME" ]   && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_STATE_HOME" ]  && export XDG_STATE_HOME="$HOME/.local/state"
[ -z "$XDG_CACHE_HOME" ]  && export XDG_CACHE_HOME="$HOME/.cache"
if [ -z "$XDG_RUNTIME_DIR" ]; then
    for dir in "/run/user/$UID" "/tmp/runtime-$UID" "$HOME/.run"; do
        mkdir -p "$dir" \
            && chmod 0700 "$dir" \
            && export XDG_RUNTIME_DIR="$dir" \
            && break
    done
fi


# ===== Programs and options ===============================

# Editor and pager
command -v vim >/dev/null 2>&1  && export EDITOR="vim"
command -v less >/dev/null 2>&1 && export PAGER="less"

# GHDL LS may get lost without this
if command -v ghdl >/dev/null 2>&1; then
    export GHDL="$(command -v ghdl)"
fi

# Less
export LESS="-Ri"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"

# Screen
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
export SCREENDIR="$XDG_RUNTIME_DIR/screen"

# Docker
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# NPM
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# Go
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"

# Ansible
export ANSIBLE_HOME="${XDG_DATA_HOME}/ansible"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible.cfg"
export ANSIBLE_GALAXY_CACHE_DIR="${XDG_CACHE_HOME}/ansible/galaxy_cache"
export ANSIBLE_LOCAL_TEMP="${XDG_CACHE_HOME}/ansible/tmp"
export ANSIBLE_SSH_CONTROL_PATH_DIR="${XDG_CACHE_HOME}/ansible/cp"
export ANSIBLE_ASYNC_DIR="${XDG_CACHE_HOME}/ansible_async"

# NVIDIA
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"


# ===== Default user and hostname ==========================
# We need to check if the variable is set to avoid overriding it
[ -z "$DEFAULT_USER" ] && export DEFAULT_USER="$(whoami)"
[ -z "$DEFAULT_HOSTNAME" ] && export DEFAULT_HOSTNAME="$(hostname)"
