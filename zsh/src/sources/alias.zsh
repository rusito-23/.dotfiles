#!/bin/zsh

# ----------------------------------------------------------------------------
# ALIAS & FUNCTIONS
# ----------------------------------------------------------------------------

# ALIAS DJANGO
alias migrate='python manage.py migrate'
alias makemigrations='python manage.py makemigrations'
alias djshell='python manage.py shell -i ipython'

# ALIAS SUDOER
alias sudoer='export ITERM_PROFILE=rusito23-zshrc ;sudo -s /bin/zsh'

# ALIAS GRADLEW
alias grdl='./gradlew'

# ----- #
# UTILS #
# ----- #

setopt noautoremoveslash
alias ls='ls -GFh'
alias l='ls'
alias la='ls -a'
alias ll='ls -FGLAhp'
alias ldir='ls -d'
alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias .6='cd ../../../../../../'
alias edit='atom'
alias f='open -a Finder ./'
alias ~='cd ~'
alias wich='type -all'
alias path='echo -e ${PATH//:\\n}'
alias src='source ~/.zshrc'
alias colors='for i in {0..255}; do printf "\x1b[38;5;${i}mcolor%-5i\x1b[0m" $i ; if ! (( ($i + 1 ) % 8 )); then echo ; fi ; done'

# ------- #
# EDITION #
# ------- #
alias mdedit='open -a MacDown'
alias vi='nvim'
alias vim='nvim'
alias nvim_rmswap='rm ~/.local/share/nvim/swap/*.swp'

# ------- #
#   DOT   #
# ------- #

dotpng() {
    dot -Tpng -Gsize=9,15\! -Gdpi=100 $1.gv -o $1.png
}

# ----------- #
# FS HANDLING #
# ----------- #

mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Create a dir and cd inside
trash () { command mv "$@" ~/.Trash ; }     # trash:        moves dir to trash
cdl () { cd "$1" && ls; }                   # cdl:          cd into dir and ls
extract () {
    # Extract most files with one command
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# ------- #
# SEARCH  #
# ------- #

alias qfind="find . -name "                 # qfind:    Look quickly for a file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file in current dir
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file in current dir with given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file in current dir that ends with given string
unalias grep
unalias fgrep
rgrep () { grep --color=auto -rInH --exclude-dir=$2 "$1" *; } 
fgrep () { grep --color=auto -rInHol --exclude-dir=$2 "$1" *; }
spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }    # spotlight : search with spotlight

# ------- #
# NETWORK #
# ------- #

alias myip='ifconfig |grep inet'
ii() {
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Current network location :$NC " ; scselect
    echo -e "\n${RED}Public facing IP Address :$NC " ;myip
    #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
    echo
}

# ------- #
#  XCODE  #
# ------- #

cleanDerivedData() {
    rm -rf $HOME/Library/Developer/Xcode/DerivedData
}
