function detach(){
    ${@:1} </dev/null &>/dev/null &
}

cdls() { cd "$1" & ls }
cdl() { cd "$1" & ls }

mkdircd() { mkdir "$1" & cd "$1" }

