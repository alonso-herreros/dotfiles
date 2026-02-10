##################
## TRUE ALIASES ##
##################

# ==== Shortcuts and shorthand ====

# One-chars
alias H='exec uwsm start hyprland.desktop || exit'
alias c='cd'
alias l='ls'
alias v='vim'
alias g='git'
alias s='ssh'
alias h='hyprctl'
alias n='nnn'
alias t='tmux'
# alias y='yazi' # sourcing the yazi_quitcd script instead

alias hg='history | grep'
alias so='source'
alias pm='pacman'
alias btctl='bluetoothctl'
alias wlc='wl-copy'
alias tf='terraform'
alias sc='sc-im'
alias trr='transmission-remote'

alias svirsh='sudo virsh'
alias sv='sudo virsh'

alias sdocker='sudo docker'
alias sd='sudo docker'
alias sdc='sudo docker-compose'
alias sdct='sudo docker container'
alias sdi='sudo docker image'

alias sctl='systemctl'
alias ssctl='sudo systemctl'
alias stui='systemctl-tui'
alias sstui='sudo systemctl-tui'
alias jctl='journalctl'
alias sjctl='sudo journalctl'

alias gimme='git clone'
alias bgo='bg 1>/dev/null 2>&1'

alias chatty='chatgpt'
alias chat='chatgpt'
alias gepeto='chatgpt'
alias gpt='chatgpt'

# Hyprctl
alias hk='hyprctl keyword'
alias hd='hyprctl dispatch'
alias hm='hyprctl keyword monitor'
alias hms='hyprctl monitors'
alias hcs='hyprctl clients'
alias hpm='hyprpm'

# Quick cd
alias ..='cd ..'
alias ...='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
function -() { cd -; }

alias bell="echo -n $'\eg\a'"

# ==== Sensible Options ====

alias ls='ls -hlA --color=auto --group-directories-first'
alias cp='cp -r'
alias mkdir='mkdir -p'

alias free='free -mht'
alias du='du -h'
alias df='df -h'
alias bc='bc -ql'

alias grep='grep --color=auto'
alias tree='tree --dirsfirst -F'

alias pacman='pacman --color=auto'
alias yay="yay --color=auto"

alias dmesg='dmesg --color=auto --reltime --human --nopager --decode'

# ==== Combos & Options ====

alias lsg='ls && echo " " && git status'
alias ks='kitten ssh'
alias sf='ssh -o ForwardAgent=yes'
alias nn='nnn -n'
alias matlabcli='matlab -nosplash -nodisplay'
alias gpconnect='sudo gpclient connect --default-browser'
alias matlabdocker="xdg-open 'https://www.mathworks.com/mwa/otp'; docker run -it --mount type=bind,src='$PWD',dst=/home/matlab/app matlab"
alias pacman-updates='pacman -Qu --color=always | less -R'
alias pmupds="pacman-updates"

alias off-the-record='unset HISTFILE; export SAVEHIST=0'
alias otr='off-the-record'

alias curl-tor='curl --socks5-hostname localhost:9050'

# ==== Easy Remember ====

alias fonts='fc-list'
alias open='xdg-open'

# ==== Confusions & Mistypes ====

alias pamcan='pacman'
alias nmctl='nmcli'
alias suod='sudo'
alias sduo='sudo'

alias dog='cat'
alias meow='cat'
alias :q='echo Not vi, but okay...; sleep 0.5; exit'
alias :e='vim'
alias :view='vim -R -c"set nomodifiable readonly"'
alias :v=':view'
alias view=':view'

# ==== Yeah ... ====
alias sudo='\sudo'
alias fucking='sudo'
alias fkin='fucking'
alias simonsays='sudo'
alias please='sudo'
alias plz='please'
alias fuck='sudo $(fc -ln -1)'
alias ffs='fuck'
alias frtho='fuck'
alias cmon='fuck'

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

function lastcmd() {
    [[ -n "$1" ]] && n="$1" || n=1
    fc -ln -$n -$n | sed 's/^\s*//'
}

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
    case "$1" in -*)
        arg="$1"
        shift;;
    esac
    kill $arg $(pgrep -u $USER ${@:1})
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

# ==== Misc? ====
function brave-2pdf() {
    if [[ -z "$1" || ! -f "$1" ]]; then
        echo "Usage: $0 <input_file> [output_file]"
        echo "Make sure the input file exists."
        exit 1
    fi

    in=$( realpath "$1" )
    out=$( realpath "${2:-${in%.*}.pdf}" )
    shift 2;

    echo "Exporting '$in' to '$out'..."

    brave --headless --disable-gpu --print-to-pdf="$out" --no-pdf-header-footer "$in"
}
