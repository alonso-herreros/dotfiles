try_source() { [[ -f "$1" ]] && source "$1"; }

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# See: https://github.com/romkatv/powerlevel10k#instant-prompt
try_source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"


export LANG=en_US.utf8

PATH="$HOME/.local/bin:$PATH"
export EDITOR="vim"
export PAGER="less"

unsetopt correct_all
unsetopt correct

# ==== Set XDG Base Directories ====

[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_CACHE_HOME" ]  && export XDG_CACHE_HOME="$HOME/.cache"
[ -z "$XDG_DATA_HOME" ]   && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_STATE_HOME" ]  && export XDG_STATE_HOME="$HOME/.local/state"

# ---- Make Zsh store its files where it should ----
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

mkdir -p "$XDG_STATE_HOME/zsh"
HISTFILE="$XDG_STATE_HOME"/zsh/history

mkdir -p "$XDG_CACHE_HOME/zsh"
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
# zcompdump handled by OMZ


# ==== Default user and hostname ====

# We need to check if the variable is set to avoid overriding it
[ -z "$DEFAULT_USER" ] && export DEFAULT_USER="$(whoami)"
[ -z "$DEFAULT_HOSTNAME" ] && export DEFAULT_HOSTNAME="$(hostname)"


# ===== Oh My Zsh! =====

export ZSH="$HOME/.scripts/oh-my-zsh"              # Path to Oh My Zsh
ZSH_CUSTOM="$XDG_CONFIG_HOME/oh-my-zsh/custom"     # Custom content folder
ZSH_CONFIG="$XDG_CONFIG_HOME/oh-my-zsh/config.zsh" # Separate config file
ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh/oh-my-zsh"      # OMZ Cache directory
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

try_source "$ZSH_CONFIG"       # Source config
try_source "$ZSH/oh-my-zsh.sh" # Source Oh My Zsh!


# ===== Powerlevel10k =====
try_source ~/.config/p10k.zsh


# ===== Aliases =====
try_source "$XDG_CONFIG_HOME/shell/alias.sh"

alias forget=' . ~/.scripts/utils/forget.zsh'
alias nvm='forget'

# Map space to expand abbr in vi insert mode
if echo "$plugins" | grep zsh-abbr >/dev/null; then
  bindkey -M viins " " abbr-expand-and-insert
  export ABBR_AUTOLOAD=0
fi


# ===== Selectively disable globbing =====
alias git='noglob git'
alias find='noglob find'


# ===== Less =====
export LESS="-Ri"


# ===== Docker =====
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock


# ===== Yazi =====
try_source ~/.scripts/rc/yazi_quitcd.sh


# ==== ghdl-ls ====
# ghdl-ls gets completely lost without this...
export GHDL="$(which ghdl)"


# ===== zsh-vi-mode =====
function zvm_config() {
  ZVM_VI_INSERT_ESCAPE_BINDKEY=kj
}

try_source "/usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"


# ==== Binds ====
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward


# ===== Local overrides =====
try_source "$ZDOTDIR/zshrc_local"
try_source ~/.zshrc_local


# ===== Clear exit status =====
true
