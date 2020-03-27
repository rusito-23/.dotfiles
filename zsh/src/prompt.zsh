#!/bin/zsh

# ----------------------------------------------------------------------------
# PROMPT
# ----------------------------------------------------------------------------
# GIT INFO IN PROMPT 
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

parse_git_dirty() {
    st=$(git status 2>/dev/null | tail -n 1)
    if [[ $st == "" ]]; then
        echo ''
    elif [[ $st == "nothing to commit, working tree clean" ]]; then
        echo ''
    elif [[ $st == "nothing to commit, working directory clean" ]]; then
        echo ''
    elif [[ $st == 'nothing added to commit but untracked files present (use "git add" to track)' ]]; then
        echo '?'
    elif [[ $st == 'no changes added to commit (use "git add" and/or "git commit -a")' ]]; then
        echo '?'
    else
        echo '*'
    fi
}

# EXPORTING PROMPT
# POWERLINE SHELL
function _update_ps1() {
    PS1=$(powerline-shell $?)
}
if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
