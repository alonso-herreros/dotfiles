export LANG=en_US.utf8

PATH="$HOME/.local/bin:$PATH"

function detach(){
    ${@:1} </dev/null &>/dev/null &
}

## synth-shell
if [ -n "$( echo $- | grep i )" ]; then
    [ -f ~/.config/synth-shell/synth-shell-greeter.sh ] && source ~/.config/synth-shell/synth-shell-greeter.sh
    [ -f ~/.config/synth-shell/synth-shell-prompt.sh ] && source ~/.config/synth-shell/synth-shell-prompt.sh
    [ -f ~/.config/synth-shell/better-ls.sh ] && source ~/.config/synth-shell/better-ls.sh
    [ -f ~/.config/synth-shell/alias.sh ] && source ~/.config/synth-shell/alias.sh
    [ -f ~/better-history.sh ] && source ~/.config/synth-shell/better-history.sh
fi

eval "$(zoxide init bash --cmd cd)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -f ~/.bashrc_local ] && source ~/.bashrc_local
