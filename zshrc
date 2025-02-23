# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# See: https://github.com/romkatv/powerlevel10k#instant-prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


export LANG=en_US.utf8

PATH="$HOME/.local/bin:$PATH"
export EDITOR="vim"
export PAGER="less -Ri"

[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"

# We need to check if the variable is set to avoid overriding it
[ -z "$DEFAULT_USER" ] && export DEFAULT_USER="$(whoami)"
[ -z "$DEFAULT_HOSTNAME" ] && export DEFAULT_HOSTNAME="$(hostname)"


# ===== Oh My Zsh! =====

export ZSH="$HOME/.scripts/oh-my-zsh"              # Path to Oh My Zsh
ZSH_CUSTOM="$XDG_CONFIG_HOME/oh-my-zsh/custom"     # Custom content folder
ZSH_CONFIG="$XDG_CONFIG_HOME/oh-my-zsh/config.zsh" # Separate config file

if [ -f "$ZSH/oh-my-zsh.sh" ]; then
    [ -f "$ZSH_CONFIG" ] && source "$ZSH_CONFIG" # Source config
    source "$ZSH/oh-my-zsh.sh"                   # Source Oh My Zsh!
fi


# ===== Powerlevel10k =====
[ -f ~/.config/p10k.zsh ] && source ~/.config/p10k.zsh


# ===== Aliases =====
# Aliases are loaded by OMZ from $ZSH_CUSTOM/aliases.zsh


# ===== Yazi =====
[ -f ~/.scripts/rc/yazi_quitcd.sh ] && source ~/.scripts/rc/yazi_quitcd.sh


# ===== zsh-vi-mode =====
function zvm_config() {
  ZVM_VI_INSERT_ESCAPE_BINDKEY=kj
}

file_arch="/usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
[ -f "$file_arch" ] && source "$file_arch"


# ===== Local overrides =====

[ -f ~/.zshrc_local ] && source ~/.zshrc_local


# ===== Clear exit status =====
true
