##################
## TRUE ALIASES ##
##################

# ==== Sensible Options ====

alias ls='ls -hlA --color=auto --group-directories-first'
alias cp='cp -r'
alias mkdir='mkdir -p'

alias free='free -mht'
alias du='du -h'
alias df='df -h'
alias bc='bc -ql'

alias grep='grep --color=auto'
alias tree='tree --dirsfirst -C'

alias pacman='pacman --color=auto'
alias yay="yay --color=auto"

alias dmesg='dmesg --color=auto --reltime --human --nopager --decode'

# ==== Easy Remember ====

alias fonts='fc-list'
alias open='xdg-open'

# ==== Shortcuts ====

# One-chars
alias v='vim'
alias g='git'
alias c='cd'
alias s='ssh'
alias n='nnn'

alias pm='pacman'

alias btctl='bluetoothctl'
alias wlc='wl-copy'

# cd back
alias ..='cd ..'
alias ...='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'

# ==== Combos & Options ====

alias lsg='ls && echo " " && git status'
alias sf='ssh -o ForwardAgent=yes'
alias nn='nnn -n'
alias matlabcli='matlab -nosplash -nodisplay'

# ==== Confusions & Mistypes ====

alias pamcan='pacman'
alias nmctl='nmcli'
alias suod='sudo'
alias sduo='sudo'
alias dog='cat'
alias meow='cat'
alias :q='echo Not vi, but ok; exit'
alias :e='vim'

# ==== Yeah ... ====
alias sudo='\sudo'
alias fucking='sudo'
alias fkin='sudo'
alias simonsays='sudo'
alias please='sudo $(history -p !!)'
alias plz='ffs'
alias cmon='ffs'
alias ffs='please'

#######################
## UTILITY FUNCITONS ##
#######################

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
alias mkcd='mkdircd'

# Getting specific lines from files or stdin
function line() {
    [[ -z $1 || $1 == "-h" ]] && echo 'Usage: line <n> [file]' && return 1
    head -n $1 $2 | tail -n 1
}

function lines() {
    [[ -z $1 || $1 == "-h" ]] && echo 'Usage: lines <a-b> [file]' && return 1
    first=$(echo $1 | cut -d '-' -f1)
    last=$(echo $1 | cut -d '-' -f2)
    num=$((last-first+1))
    head -n $last $2 | tail -n $num
}

# ==== User-scope process operations ====
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

