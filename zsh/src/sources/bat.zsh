# taken from: https://github.com/sharkdp/bat

tail() {
    tail -f $1 | bat --paging=never -l log
}

