export LANG=en_US.utf8

PATH="$HOME/.local/bin:$PATH"

## synth-shell
if [ -n "$( echo $- | grep i )" ]; then
    # [ -f ~/.config/synth-shell/synth-shell-greeter.sh ] && source ~/.config/synth-shell/synth-shell-greeter.sh
    [ -f ~/.config/synth-shell/synth-shell-prompt.sh ] && source ~/.config/synth-shell/synth-shell-prompt.sh
    # [ -f ~/.config/synth-shell/better-ls.sh ] && source ~/.config/synth-shell/better-ls.sh
    [ -f ~/.config/synth-shell/alias.sh ] && source ~/.config/synth-shell/alias.sh
    [ -f ~/better-history.sh ] && source ~/.config/synth-shell/better-history.sh
fi

alias ss-greeter="source ~/.config/synth-shell/synth-shell-greeter.sh"


eval "$(zoxide init bash --cmd cd)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash || eval "$(fzf --bash)"

[ -f ~/.scripts/rc/alias.sh ] && source ~/.scripts/rc/alias.sh

[ -f ~/.bashrc_local ] && source ~/.bashrc_local

[ -f /usr/share/git/completion/git-completion.bash ] && source /usr/share/git/completion/git-completion.bash

# Should be set by services and the Desktop Environment. It can fuck shit up in cases like Agent Forwarding
# export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

export EDITOR=vim
export PAGER="less -Ri"

# ==== nnn ====
[ -f ~/.scripts/rc/nnn_quitcd.sh ] && source ~/.scripts/rc/nnn_quitcd.sh
# export NNN_OPTS="aAcEGHiQRux" # Must be compiled with O_GITSTATUS=1
export NNN_OPTS="aAcEHiQRux"
export NNN_TRASH=2
export NNN_PLUG="v:-preview-tui;s:-!git status;d:-!git diff"

