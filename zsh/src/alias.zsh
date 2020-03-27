#!/bin/zsh

# ----------------------------------------------------------------------------
# ALIAS & FUNCTIONS
# ----------------------------------------------------------------------------

# ALIAS DJANGO
alias migrate='python manage.py migrate'
alias makemigrations='python manage.py makemigrations'
alias djshell='python manage.py shell -i ipython'

# ALIAS SUDOERR
alias sudoer='export ITERM_PROFILE=rusito23-zshrc ;sudo -s /bin/zsh'

# ALIAS GRADLEW
alias grdl='./gradlew'

# ALIAS TMUX
alias tmuxx='tmux source-file ~/.tmux.conf'

# ----------- #
# PROGRAMMING #
# ----------- #
alias markdown='~/Markdown_1.0.1/Markdown.pl'
alias omnet='~/omnetpp-5.2.1/bin/omnetpp'
alias py='ipython'              # py : ipython shell
alias subl='sublime_text'       # subl : sublime text
alias sdb='./opt/android-sdk/platform-tools/adb'
alias emacs="emacs -nw"
alias fromscratch="FromScratch --portable ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/fromscratch &"
alias glogg="open -a glogg"

# ----- #
# UTILS #
# ----- #
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
alias f='open -a Finder ./'         # f: open in Finder
alias ~='cd ~'
alias wich='type -all'              # which: find executables
alias path='echo -e ${PATH//:\\n}'
alias src='source ~/.zshrc'         # Load shell config

# ------- #
# EDITION #
# ------- #
alias vimedit='vim ~/.vim_runtime/my_configs.vim'
alias mdedit='open -a MacDown'
alias pcat='pygmentize -f terminal256 -O style=monokai -g'
alias vi='nvim'
alias vim='nvim'

# ------- #
#   DOT   #
# ------- #
dotpng() {
    dot -Tpng -Gsize=9,15\! -Gdpi=100 $1.gv -o $1.png && imgcat $1.png 
}

# ------- #
#   ML    #
# ------- #
alias jupyn='jupyter notebook'

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

extract-all() {
    # Extract all files in folder

    for X in *; do
        extract $X
    done
}

# ------- #
# SEARCH  #
# ------- #
alias qfind="find . -name "                 # qfind:    Look quickly for a file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file in current dir
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file in current dir with given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file in current dir that ends with given string
# rgrep() { grep -rInH "$@" . }               # rgrep:    Recursive search of text in current dir
rgrep() {                                 # rgrepnd:  rgrep excluding dir!
    grep -rInH --exclude-dir=$2 "$1" .
} 
alias egrep="egrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"
alias grephist="pcat ~/.zsh_history |grep "

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

# -------------------- #
#     XCODE COMMANDS   #
# -------------------- #

excalibur() {
    cd /excalibur-ios
    
    xcodebuild \
        -UseModernBuildSystem=NO \
        -workspace /excalibur-ios/excalibur.xcworkspace \
        -scheme  Royal-Dev \
        -sdk iphonesimulator \
        -destination 'platform=iOS Simulator,name=iPhone 6,OS=12.1' \
        "$@" | xcpretty --test --color
}

cleanDerivedData() {
    rm -rf $HOME/Library/Developer/Xcode/DerivedData
}


# -------------------- #
#     XCODE COMMANDS   #
# -------------------- #

tomcatShutDown() {
    cd $tomcatHome/bin && ./shutdown.sh
}

