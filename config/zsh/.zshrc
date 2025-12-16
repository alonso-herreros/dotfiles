# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# See: https://github.com/romkatv/powerlevel10k#instant-prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


export LANG=en_US.utf8

PATH="$HOME/.local/bin:$PATH"
export EDITOR="vim"
export PAGER="less -Ri"

unsetopt correct_all
unsetopt correct

# ==== Set XDG Base Directories ====

[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_CACHE_HOME" ]  && export XDG_CACHE_HOME="$HOME/.cache"
[ -z "$XDG_DATA_HOME" ]   && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_STATE_HOME" ]  && export XDG_STATE_HOME="$HOME/.local/state"

# ---- Make Zsh store its files where it should ----
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

[ -d "$XDG_STATE_HOME/zsh" ] || mkdir -p "$XDG_STATE_HOME/zsh"
HISTFILE="$XDG_STATE_HOME"/zsh/history

[ -d "$XDG_CACHE_HOME/zsh" ] || mkdir -p "$XDG_CACHE_HOME/zsh"
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

if [ -f "$ZSH/oh-my-zsh.sh" ]; then
    [ -f "$ZSH_CONFIG" ] && source "$ZSH_CONFIG" # Source config
    source "$ZSH/oh-my-zsh.sh"                   # Source Oh My Zsh!
fi


# ===== Powerlevel10k =====
[ -f ~/.config/p10k.zsh ] && source ~/.config/p10k.zsh


# ===== Aliases =====
[ -f "$XDG_CONFIG_HOME/shell/alias.sh" ] && source "$XDG_CONFIG_HOME/shell/alias.sh"


# ===== Selectively disable globbing =====
alias git='noglob git'
alias find='noglob find'


# ===== Docker =====
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock


# ===== Yazi =====
[ -f ~/.scripts/rc/yazi_quitcd.sh ] && source ~/.scripts/rc/yazi_quitcd.sh


# ==== ghdl-ls ====
# ghdl-ls gets completely lost without this...
export GHDL="$(which ghdl)"


# ===== zsh-vi-mode =====
function zvm_config() {
  ZVM_VI_INSERT_ESCAPE_BINDKEY=kj
}

file_arch="/usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
[ -f "$file_arch" ] && source "$file_arch"


# ==== Binds ====
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward


# ===== Local overrides =====

[ -f "$ZDOTDIR/zshrc_local" ] && source "$ZDOTDIR/zshrc_local"
[ -f ~/.zshrc_local ] && source ~/.zshrc_local


# ===== Clear exit status =====
true
