
# Zsh configuration
export TERM="xterm-256color"
export ZSH=$HOME/.oh-my-zsh
ZSH_DISABLE_COMPFIX="true"

# Setup extra paths
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.dotfiles/bin:$PATH
export PATH=/usr/local/bin:$PATH

# Set zsh theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Setup plugins
plugins=(
    sudo
    git
    fast-syntax-highlighting
    zsh-autosuggestions
    virtualenv
    tmux
    tmux-cssh
    docker
    docker-compose
    calc
)

# Set editor & pager
export VISUAL=nvim
export EDITOR=nvim
export PAGER=less
export LESS=-FRX

# Load powerlevel configuration
source $HOME/.dotfiles/powerlevelrc

# Zsh Plugin configuration
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOCONNECT=false

# Load oh my zsh
source $ZSH/oh-my-zsh.sh

# Custom plugins configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Show welcome message
[[ -o login ]] && echo "ПРИВЕТ СУКА БЛЯТЬ"

# Load shell integration
[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh

# Load ignored files
for s in $HOME/.dotfiles/ignored/*; do source $s; done

# Quick-reload alias
alias src='source ~/.zshrc'

# Setup navigation aliases
setopt noautoremoveslash
alias ls='ls -GFh'
alias l='ls'
alias la='ls -a'
alias ll='ls -FGLAhp'
alias ldir='ls -d'
alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../../'

# Setup tmux aliases
alias tmuxx='tmux source-file ~/.tmux.conf'
alias unsetmux='OLD_TMUX=$TMUX;TMUX=""'
alias resetmux='TMUX=$OLD_TMUX'

# Init `fasd`
eval "$(fasd --init auto)"
autoload -U compinit && compinit -U

# Setup `rg` config file
export RIPGREP_CONFIG_PATH="$HOME/.dotfiles/ripgreprc"

# Setup `fzf`
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='-i --height 50% --border --inline-info '

# `fzf` + `tmux` aliases
alias fr='fzf-tmux -r 60'
alias fl='fzf-tmux -l 60'

# Setup `git` + `fzf` plugin
# Taken and modified from:
# https://junegunn.kr/2016/07/fzf-git
# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

# Search repo files
fzf_gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

# Search branches
fzf_go() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf --ansi --multi --tac --preview-window right:50% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

# Search tags
fzf_gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf --multi --preview-window right:50% \
    --preview 'git show --color=always {} | head -'$LINES
}

# Search commit hashes
fzf_gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

# Search remotes
fzf_gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

# Setup `git` + `fzf` key bindings

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(fzf_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}

bind-git-helper f o t r h
unset -f bind-git-helper


# Sudoer alias
alias sudoer='export ITERM_PROFILE=rusito23-zshrc ;sudo -s /bin/zsh'

# Edition & QuickLook aliases
alias mdedit='open -a MacDown'
alias vi='nvim'
alias vim='nvim'
alias nvim_rmswap='rm ~/.local/share/nvim/swap/*.swp'
alias cat='bat'
alias diff='nvim -d '
alias imcat='shellpic --shell24'
alias ql='qlmanage -p > /dev/null 2> /dev/null'
alias xargs='xargs -I%'

# IP Lookup
# Parameter:
# - opendns: public ip via opendns server (default)
# - google: public ip via google dns server
# - local for local ip
myip() {
    if [[ "$1" == "local" ]]; then
        echo "-- Local IP Lookup --"
        ifconfig | grep inet
    elif [[ "$1" == "google" ]]; then
        echo "-- Public IP Lookup via Google DNS server --"
        dig TXT +short o-o.myaddr.l.google.com @ns1.google.com
    elif [[ "$1" == "opendns" ]] || [[ "$1" == "" ]]; then
        echo "-- Public IP Lookup via OpenDNS server --"
        dig +short myip.opendns.com @resolver1.opendns.com
    fi
}

# Cycle through auto suggestions with up/down

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


# `git` plugin custom extensions

# Add remote, fetch and checkout branch in a single command
# Parameters:
#   - remote
#   - branch name
gaco() {
    if [ $# -ne 2 ]; then
        echo "Usage: gaco remote branch"
        return 1
    fi

    git remote set-branches --add $@
    git fetch $@
    git checkout $2
}

# Current branch name alias
unalias gcb
alias gcb='git_current_branch'

# Diff and merge tools aliases
alias gdt='git difftool'
alias gmt='git mergetool'

# Use lease when force-pushing
ggpf () {
    if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]
    then
        git push --force-with-lease origin "${*}"
    else
        [[ "$#" == 0 ]] && local b="$(git_current_branch)"
        git push --force-with-lease origin "${b:=$1}"
    fi
}

# Create a feature branch
gcofeat() {
    branch=${2/\//_} # remove / from the description
    branch=${branch// /_} # replace spaces with _
    git checkout -b "$1/feature/${branch}"
}

# Create a bugfix branch
gcofix() {
    branch=${2/\//_} # remove / from the description
    branch=${branch// /_} # replace spaces with _
    git checkout -b "$1/bugfix/${branch}"
}

# Remove upstream push alias (it's f* dangerous)
# and create a function that pulls from upstream instead
unalias gpu
glu () {
    if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]
    then
        git pull upstream "${*}"
    else
        [[ "$#" == 0 ]] && local b="$(git_current_branch)"
        git pull upstream "${b:=$1}"
    fi
}

# Setup `gitignore.io`
function gi() { curl -sL https://www.gitignore.io/api/$@ ;}

function _gitignoreio_get_command_list() {
  curl -sL https://www.gitignore.io/api/list | tr "," "\n"
}

function _gitignoreio () {
  compset -P '*,'
  compadd -S '' `_gitignoreio_get_command_list`
}

compdef _gitignoreio gi

# Checkout a GH PR
# Assuming that `upstream` contains the original repo remote
function gcopr() {
    git fetch upstream pull/$1/head:pr-$1 && \
    git checkout pr-$1
}

# Go Version Manager configuration
(( ${+aliases[g]} )) && unalias g
export GOPATH="$HOME/go";
export GOROOT="$HOME/.go";
export PATH="$GOPATH/bin:$PATH";
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# Setup virtualenv home
export VIRTUALENVWRAPPER_PYTHON=$HOME/.pyenv/shims/python
export WORKON_HOME=$HOME/.virtualenvs
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# `virtualenvwrapper` aliases
alias vew='virtualenvwrapper'
alias mkve='mkvirtualenv'
alias rmve='rmvirtualenv'
alias lve='lsvirtualenv'

# ipython alias
alias py='ipython'

# jupyter aliases
alias jn='jupyter notebook'
alias jl='jupyter lab'

# pyenv init
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path -)"
    pyenv virtualenvwrapper
fi

# FUCK!
eval $(thefuck --alias)

# Docker Helpers

# Purge the entire docker stuff
function docker_purge() {
    docker rm -f $(docker ps -aq)
    docker rmi -f $(docker images -aq)
    docker volume rm $(docker volume ls -q)
    docker system prune
}

# Setup `cheat`auto-complete
function _cheat_get_list() {
    ls ~/.dotfiles/cheatsheets | \
        awk -F. '{print $1}' | \
        tr '[:upper:]' '[:lower:]'
}
function _cheat() {
    compset -P '*,'
    compadd -S '' `_cheat_get_list`
}
compdef _cheat cheat
