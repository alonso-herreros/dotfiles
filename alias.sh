function detach(){
    ${@:1} </dev/null &>/dev/null &
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

