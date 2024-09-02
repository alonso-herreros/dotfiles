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

function ozone-wayland() {
    ${@:1} --enable-features=UseOzonePlatform --ozone-platform=wayland
}

alias lsg="ls && echo ' ' && git status"
alias fonts="fc-list"
alias open="xdg-open"

alias yay="yay --color=auto"
alias btctl="bluetoothctl"

alias v="vim"
alias g="git"
alias c="cd"
alias n="nnn"
alias nn="nnn -n"

