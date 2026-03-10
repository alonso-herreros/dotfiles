try_source() { [[ -f "$1" ]] && source "$1"; }

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# See: https://github.com/romkatv/powerlevel10k#instant-prompt
try_source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

# ===== Environment vars =====
try_source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/env.sh"

unsetopt correct_all
unsetopt correct

# ---- Make Zsh store its files where it should ----
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

mkdir -p "$XDG_STATE_HOME/zsh"
HISTFILE="$XDG_STATE_HOME"/zsh/history

mkdir -p "$XDG_CACHE_HOME/zsh"
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
# zcompdump handled by OMZ


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


# ===== Yazi =====
try_source ~/.scripts/rc/yazi_quitcd.sh


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
