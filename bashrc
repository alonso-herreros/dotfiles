PATH="$HOME/.local/bin:$PATH"

function detach(){
    ${@:1} </dev/null &>/dev/null &
}

##-----------------------------------------------------
## synth-shell-greeter.sh
if [ -f /usr/lab/alum/0493990/.config/synth-shell/synth-shell-greeter.sh ] && [ -n "$( echo $- | grep i )" ]; then
    source /usr/lab/alum/0493990/.config/synth-shell/synth-shell-greeter.sh
fi

##-----------------------------------------------------
## synth-shell-prompt.sh
if [ -f /usr/lab/alum/0493990/.config/synth-shell/synth-shell-prompt.sh ] && [ -n "$( echo $- | grep i )" ]; then
    source /usr/lab/alum/0493990/.config/synth-shell/synth-shell-prompt.sh
fi

##-----------------------------------------------------
## better-ls
if [ -f /usr/lab/alum/0493990/.config/synth-shell/better-ls.sh ] && [ -n "$( echo $- | grep i )" ]; then
    source /usr/lab/alum/0493990/.config/synth-shell/better-ls.sh
fi

##-----------------------------------------------------
## alias
if [ -f /usr/lab/alum/0493990/.config/synth-shell/alias.sh ] && [ -n "$( echo $- | grep i )" ]; then
    source /usr/lab/alum/0493990/.config/synth-shell/alias.sh
fi

##-----------------------------------------------------
## better-history
if [ -f /usr/lab/alum/0493990/.config/synth-shell/better-history.sh ] && [ -n "$( echo $- | grep i )" ]; then
    source /usr/lab/alum/0493990/.config/synth-shell/better-history.sh
fi

eval "$(zoxide init bash --cmd cd)"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
