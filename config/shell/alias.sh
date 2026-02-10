##################
## TRUE ALIASES ##
##################

# Align with                                      (align here:) #abbr
#     :EasyAlign */#abbr/ig[]dr

# ==== Shortcuts and shorthand ====

# One-chars
alias H='exec uwsm start hyprland.desktop || exit'
alias c='cd'                                                    #abbr
alias l='ls'                                                    #abbr
alias v='vim'                                                   #abbr
alias g='git'                                                   #abbr
alias s='ssh'                                                   #abbr
alias h='hyprctl'                                               #abbr
alias n='nnn'                                                   #abbr
alias t='tmux'                                                  #abbr
# alias y='yazi' # sourcing the yazi_quitcd script instead

alias hg='history | grep'                                       #abbr
alias so='source'                                               #abbr
alias pm='pacman'                                               #abbr
alias btctl='bluetoothctl'                                      #abbr
alias wlc='wl-copy'                                             #abbr
alias tf='terraform'                                            #abbr
alias sc='sc-im'                                                #abbr
alias trr='transmission-remote'                                 #abbr

alias svirsh='sudo virsh'                                       #abbr
alias sv='sudo virsh'                                           #abbr

alias sdocker='sudo docker'                                     #abbr
alias sd='sudo docker'                                          #abbr
alias sdc='sudo docker-compose'                                 #abbr
alias sdct='sudo docker container'                              #abbr
alias sdi='sudo docker image'                                   #abbr

alias sctl='systemctl'                                          #abbr
alias ssctl='sudo systemctl'                                    #abbr
alias stui='systemctl-tui'                                      #abbr
alias sstui='sudo systemctl-tui'                                #abbr
alias jctl='journalctl'                                         #abbr
alias sjctl='sudo journalctl'                                   #abbr

alias gimme='git clone'                                         #abbr
alias bgo='bg 1>/dev/null 2>&1'

alias chatty='chatgpt'
alias chat='chatgpt'                                            #abbr
alias gepeto='chatgpt'
alias gpt='chatgpt'                                             #abbr

# Hyprctl
alias hk='hyprctl keyword'                                      #abbr
alias hd='hyprctl dispatch'                                     #abbr
alias hm='hyprctl keyword monitor'                              #abbr
alias hms='hyprctl monitors'                                    #abbr
alias hcs='hyprctl clients'                                     #abbr
alias hpm='hyprpm'                                              #abbr

# Quick cd
alias ..='cd ..'                                                #abbr
alias ...='cd ../..'                                            #abbr
alias ....='cd ../../..'                                        #abbr
alias .....='cd ../../../..'                                    #abbr
alias ..2='cd ../..'                                            #abbr
alias ..3='cd ../../..'                                         #abbr
alias ..4='cd ../../../..'                                      #abbr
alias ..5='cd ../../../../..'                                   #abbr
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
alias ks='kitten ssh'                                           #abbr
alias sf='ssh -o ForwardAgent=yes'                              #abbr
alias nn='nnn -n'                                               #abbr
alias matlabcli='matlab -nosplash -nodisplay'
alias gpconnect='sudo gpclient connect --default-browser'       #abbr
alias matlabdocker="xdg-open 'https://www.mathworks.com/mwa/otp'; docker run -it --mount type=bind,src='$PWD',dst=/home/matlab/app matlab"
alias pacman-updates='pacman -Qu --color=always | less -R'      #abbr
alias pmupds="pacman-updates"                                   #abbr

alias off-the-record='unset HISTFILE; export SAVEHIST=0'
alias otr='off-the-record'                                      #abbr

alias curl-tor='curl --socks5-hostname localhost:9050'

# ==== Easy Remember ====

alias fonts='fc-list'                                           #abbr
alias open='xdg-open'                                           #abbr

# ==== Confusions & Mistypes ====

alias pamcan='pacman'                                           #abbr
alias nmctl='nmcli'                                             #abbr
alias suod='sudo'                                               #abbr
alias sduo='sudo'                                               #abbr
alias pign='ping'                                               #abbr

alias dog='cat'
alias meow='cat'
alias :q='echo Not vi, but okay...; sleep 0.5; exit'
alias :e='vim'                                                  #abbr
alias view='vim -R -c"set nomodifiable readonly"'
alias :view='view'                                              #abbr
alias :v='view'                                                 #abbr

# ==== Yeah ... ====
alias sudo='\sudo'
alias fucking='sudo'
alias fkin='fucking'                                            #abbr
alias simonsays='sudo'
alias please='sudo'
alias plz='please'                                              #abbr
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
alias mkcd='mkdircd'                                            #abbr

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
