#!/bin/sh
source $HOME/.dotfiles/zsh/source/dirs.zsh
source $ASSETS_DIR/colors.zsh


# ------------------- #
#   WELCOME MESSAGE   #
# ------------------- #
if [[ -o login ]]; then
    echo "ПРИВЕТ СУКА БЛЯТЬ"
fi


# ------------------- #
#   SHELL INTEGRATION #
# ------------------- #
if [ -f ~/.iterm2_shell_integration.zsh ]; then
    source ~/.iterm2_shell_integration.zsh
fi


# ---------- #
#   IGNORED  #
# ---------- #
for s in $SOURCES_DIR/ignored/*; do source $s; done

# ------- #
#   MISC  #
# ------- #

alias src='source ~/.zshrc'
alias sudoer='export ITERM_PROFILE=rusito23-zshrc ;sudo -s /bin/zsh'

# -------- #
#   PATHS  #
# -------- #

export PATH=$HOME/.local/bin:$PATH

# ------------ #
#  NAVIGATION  #
# ------------ #

setopt noautoremoveslash
alias ls='ls -GFh'
alias l='ls'
alias la='ls -a'
alias ll='ls -FGLAhp'
alias ldir='ls -d'
alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../../'

# ------- #
# EDITION #
# ------- #

alias mdedit='open -a MacDown'
alias vi='nvim'
alias vim='nvim'
alias nvim_rmswap='rm ~/.local/share/nvim/swap/*.swp'
alias cat='bat'
alias diff='nvim -d '

# ------- #
# SEARCH  #
# ------- #

alias qfind="find . -name "                 # qfind:    Look quickly for a file
((${+aliases[rgrep]})) && unalias rgrep
((${+aliases[fgrep]})) && unalias fgrep
rgrep () { grep --color=auto -rInH --exclude-dir=$2 "$1" * ;}
fgrep () { grep --color=auto -rInHol --exclude-dir=$2 "$1" * ;}

# ------- #
# NETWORK #
# ------- #

alias myip='ifconfig |grep inet'

# ---------------- #
# AUTOSUGGESTIONS  #
# ---------------- #

# cycle through auto suggestions with up/down

if [[ "${terminfo[kcuu1]}" != "" ]]; then
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search
    bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

if [[ "${terminfo[kcud1]}" != "" ]]; then
    autoload -U down-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi


# ---------------- #
#       FASD       #
# ---------------- #

eval "$(fasd --init auto)"
autoload -U compinit && compinit

# -------------------- #
# GIT PLUGIN EXTENSION #
# -------------------- #

github() { git clone https://github.com/$1.git $2 ;}
bitbucket() { git clone https://bitbucket.org/$1.git $2 ;}

# fetch and checkout branch in a single command
gfco() { git fetch origin $@ ; git checkout $@ ;}

# diff and mergetools
alias gdt='git difftool'
alias gmt='git mergetool'

# don't git push force, git push force with lease!
alias ggpf='ggp --force-with-lease'

# CHECKOUT SANDBOX - FEATURE - FIX
gcosand() { git checkout -b "sandbox/$1/$2" ;}
gcofeat() {
    branch=${@/\//_} # remove /
    branch=${branch// /_} # replace spaces with _
    git checkout -b "feature/${branch}"
}
gcofix() {
    branch=${@/\//_} # remove /
    branch=${branch// /_} # replace spaces with _
    git checkout -b "bugfix/${branch}"
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


# ---------------- #
#        GO        #
# ---------------- #

# GO VERSION MANAGER
(( ${+aliases[foo]} )) && unalias g
export GOPATH="$HOME/go";
export GOROOT="$HOME/.go";
export PATH="$GOPATH/bin:$PATH";


# ---------------- #
#      PYTHON      #
# ---------------- #

# virtualenvwrapper aliases
alias vew='virtualenvwrapper'
alias mkve='mkvirtualenv'
alias rmve='rmvirtualenv'
alias lve='lsvirtualenv'

# ipython
alias py='ipython'

# jupyter aliases
alias jn='jupyter notebook'
alias jl='jupyter lab'

# pyenv init
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    pyenv virtualenvwrapper
fi


# ---------------- #
#      TMUX        #
# ---------------- #

alias tmuxx='tmux source-file ~/.tmux.conf'
# set unset tmux for nested sessions
alias unsetmux='OLD_TMUX=$TMUX;TMUX=""'
alias resetmux='TMUX=$OLD_TMUX'

# ---------------- #
#        FZF       #
# ---------------- #
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 50% --border --exact --inline-info'
# ---------------- #
#    FZF + TMUX    #
# ---------------- #
alias fr='fzf-tmux -r 60'
alias fl='fzf-tmux -l 60'
# ---------------- #
#    FZF + GIT     #
# ---------------- #
alias gbf='gco $(gb | fr)'
alias gcf='glo | fr'
