##################
## TRUE ALIASES ##
##################

# ==== Sensible Options ====

alias ls='\ls -hlA --color=auto --group-directories-first'
alias grep='\grep --color=auto'
alias pacman='\pacman --color=auto'
alias yay="yay --color=auto"
alias tree='\tree --dirsfirst -C'
alias dmesg='\dmesg --color=auto --reltime --human --nopager --decode'
alias free='\free -mht'

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

alias btctl='bluetoothctl'
alias wlc='wl-copy'

# ==== Combos & Options ====

alias lsg='ls && echo ' ' && git status'
alias sf='ssh -o ForwardAgent=yes'
alias nn='nnn -n'
alias matlabcli='matlab -nosplash -nodisplay'

# ==== Confusions & Mistypes ====

alias pamcan='pacman'
alias nmctl='nmcli'

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

