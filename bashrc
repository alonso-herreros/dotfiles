export LANG=en_US.utf8

PATH="$HOME/.local/bin:$PATH"
export EDITOR=vim
export PAGER="less -Ri"

#################
## synth-shell ##
#################

if [ -n "$( echo $- | grep i )" ]; then
    # [ -f ~/.config/synth-shell/synth-shell-greeter.sh ] && source ~/.config/synth-shell/synth-shell-greeter.sh
    [ -f ~/.config/synth-shell/synth-shell-prompt.sh ] && source ~/.config/synth-shell/synth-shell-prompt.sh
    # [ -f ~/.config/synth-shell/better-ls.sh ] && source ~/.config/synth-shell/better-ls.sh
    # [ -f ~/.config/synth-shell/alias.sh ] && source ~/.config/synth-shell/alias.sh
    [ -f ~/better-history.sh ] && source ~/.config/synth-shell/better-history.sh
fi

# [ -f ~/.scripts/rc/alias.sh ] && source ~/.scripts/rc/alias.sh
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

eval "$(zoxide init bash --cmd cd)"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash || eval "$(fzf --bash)"
[ -f /usr/share/git/completion/git-completion.bash ] && source /usr/share/git/completion/git-completion.bash

# Should be set by services and the Desktop Environment. It can fuck shit up in cases like Agent Forwarding
# export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

# ==== nnn ====
[ -f ~/.scripts/rc/nnn_quitcd.sh ] && source ~/.scripts/rc/nnn_quitcd.sh
# export NNN_OPTS="aAcEGHiQRux" # Must be compiled with O_GITSTATUS=1
export NNN_OPTS="aAcEHiQRux"
export NNN_TRASH=2
export NNN_PLUG="v:-preview-tui;e:-!echo $nnn|wl-copy*;c:-!echo $PWD/$nnn|wl-copy*"

#####################
## LOCAL OVERRIDES ##
#####################

[ -f ~/.bashrc_local ] && source ~/.bashrc_local
