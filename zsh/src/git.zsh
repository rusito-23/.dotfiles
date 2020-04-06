#!/bin/zsh
source $HOME/.dotfiles/zsh/src/dirs.zsh
source $ASSETS_DIR/colors.zsh 

# -------------------- #
# GIT PLUGIN EXTENSION #
# -------------------- #

# USE: gcmrplauthor <author> <commit-hash>
gcmrplauthor() {
    echo "${BGreen}Replacing autor with: $1 on commit: $2"

    branch=`git symbolic-ref --short -q HEAD`
    echo "Branch --> ${branch} ${Color_Off}"

    # checkout & ammend
    git checkout $2
    git commit --amend --author $1

    # retrieve hash of new commit 
    new_cm_hash=`git rev-parse --short HEAD`

    # checkout original branch 
    git checkout $branch

    # replace the commit
    git replace $2 $new_cm_hash

    echo "${BGreen}Commit replaced! ${Color_Off}"
    echo "Please use ${BRed}git push --force-with-lease${Color_Off} to save your changes"
}


# AUTO-COMPLETE THE GIT URL! 
# USE : github <repo> <destination>
github() {
    git clone https://github.com/$1.git $2
}

bitbucket() {
    git clone https://bitbucket.org/$1.git $2
}

# Fetch and checkout branch in a single command
gfco() {
    echo "\nFetching and checking: $@"
    git fetch origin $@
    git checkout $@
}

# Diff and mergetools
alias gdt='git difftool'
alias gmt='git mergetool'

# Git parent branch:
gpb() {
    git show-branch -a 2> /dev/null \
        | grep '\*' \
        | grep -v `git rev-parse --abbrev-ref HEAD` \
        | head -n1 \
        | sed 's/.*\[\(.*\)\].*/\1/' \
        | sed 's/[\^~].*//' \
}


# CHECKOUT SANDBOX & FEATURE

# params: $1 -> commitername, $2 -> sandboxname
gcosand() {
    git checkout -b "sandbox/$1/$2" 
}

gcofeat() {
    branch=$@
    git checkout -b "feature/${branch// /_}"
}

gcofix() {
    branch=$@
    echo "bugfix/${branch// /_}"
}

# SEARCH FOR TODO'S IN YOUR CHANGES:

gstodo() {
    gd | egrep "TODO|todo"
    gd --cached | egrep "TODO|todo"
}

# gitignore.io

function gi() { curl -sL https://www.gitignore.io/api/$@ ;}

_gitignoreio_get_command_list() {
  curl -sL https://www.gitignore.io/api/list | tr "," "\n"
}

_gitignoreio () {
  compset -P '*,'
  compadd -S '' `_gitignoreio_get_command_list`
}

compdef _gitignoreio gi
