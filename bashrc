export LANG=en_US.utf8

PATH="$HOME/.local/bin:$PATH"

## synth-shell
if [ -n "$( echo $- | grep i )" ]; then
    # [ -f ~/.config/synth-shell/synth-shell-greeter.sh ] && source ~/.config/synth-shell/synth-shell-greeter.sh
    [ -f ~/.config/synth-shell/synth-shell-prompt.sh ] && source ~/.config/synth-shell/synth-shell-prompt.sh
    [ -f ~/.config/synth-shell/better-ls.sh ] && source ~/.config/synth-shell/better-ls.sh
    [ -f ~/.config/synth-shell/alias.sh ] && source ~/.config/synth-shell/alias.sh
    [ -f ~/better-history.sh ] && source ~/.config/synth-shell/better-history.sh
fi

alias ss-greeter="source ~/.config/synth-shell/synth-shell-greeter.sh"


eval "$(zoxide init bash --cmd cd)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash || eval "$(fzf --bash)"

[ -f ~/.config/alias.sh ] && source ~/.config/alias.sh

[ -f ~/.bashrc_local ] && source ~/.bashrc_local

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
