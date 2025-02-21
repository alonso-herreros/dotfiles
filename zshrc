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

export ZSH="$HOME/.oh-my-zsh" # Path to Oh My Zsh installation
# ZSH_CUSTOM="$ZSH/custom"      # Custom content folder

if [ -f "$ZSH/oh-my-zsh.sh" ]; then
    # Source configuration, stored separately
    source "$XDG_CONFIG_HOME/oh-my-zsh.zsh" 2>/dev/null

    source "$ZSH/oh-my-zsh.sh"    # source Oh My Zsh!
fi


# ===== Powerlevel10k =====
[ -f ~/.config/p10k.zsh ] && source ~/.config/p10k.zsh


# ===== Aliases =====
# Aliases are loaded by OMZ from $ZSH_CUSTOM/aliases.zsh


# ===== Yazi =====
[ -f ~/.scripts/rc/yazi_quitcd.sh ] && source ~/.scripts/rc/yazi_quitcd.sh


# ===== Local overrides =====

[ -f ~/.zshrc_local ] && source ~/.zshrc_local


# ===== Clear exit status =====
true
