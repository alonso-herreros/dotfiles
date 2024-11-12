function detach(){
    setsid ${@:1} >/dev/null 2>&1 < /dev/null &
}

function cdls() {
    cd ${@:1}
    ls
}
function cdl() {
    cd ${@:1}
    ls
}
function mkdircd() {
    mkdir ${@:1}
    cd ${@:1}
}

function upgrep() {
    pgrep -u $USER ${@:1}
}
function upkill() {
    kill $(pgrep -u $USER ${@:1})
}
function uprestart() {
    kill $(pgrep -u $USER $1); detach ${@:1}
}

function ozone-wayland() {
    ${@:1} --enable-features=UseOzonePlatform --ozone-platform=wayland
}

function sshback() {
    ssh $SSH_MASTER_USER@master ${@:1}
}

alias ls="ls -hlA --color=auto --group-directories-first"
alias lsg="ls && echo ' ' && git status"
alias fonts="fc-list"
alias open="xdg-open"
alias wlc="wl-copy"

alias yay="yay --color=auto"
alias btctl="bluetoothctl"

alias v="vim"
alias g="git"
alias c="cd"
alias s="ssh"
alias sf="ssh -o ForwardAgent=yes"
alias nn="nnn -n"

alias matlabcli="matlab -nosplash -nodisplay"

