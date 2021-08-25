# zshrc
# My ZSH config file

# -----------------------
# GENERAL CONFIGS

# General configuration
export TERM="xterm-256color"
export ZSH=$HOME/.oh-my-zsh
ZSH_DISABLE_COMPFIX="true"

# Set up paths
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.dotfiles/bin:$PATH
export PATH=/usr/local/bin:$PATH

# Set zsh theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set plugins
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

# Set editor & pager configuration
export VISUAL=nvim
export EDITOR=nvim
export PAGER=less
export LESS=-FRX

# Load powerlevel configuration
source $HOME/.dotfiles/powerlevelrc

# Tmux configuration
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOCONNECT=false

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Auto suggestions plugin configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Display welcome message
[[ -o login ]] && echo "ПРИВЕТ СУКА БЛЯТЬ"

# Load ignored files
for s in $HOME/.dotfiles/ignored/*; do source $s; done

# General opt config
setopt noautoremoveslash

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

# -----------------------
# ALIASES

alias src='source ~/.zshrc'     # Quick reload
alias ls='ls -GFh'              # Default ls config
alias la='ls -a'                # Hidden files
alias cd..='cd ../'             # Fix common typo
alias ..='cd ../'               # Navigate with dots
alias ...='cd ../../'           # Navigate with dots

alias unsetmux='OLD_TMUX=$TMUX;TMUX=""'         # Enable nested tmux sessions
alias resetmux='TMUX=$OLD_TMUX'                 # Disable nested tmux sessions

alias fr='fzf-tmux -r 60'               # Start fzf in a right tmux pane
alias fl='fzf-tmux -l 60'               # Start fzf in a left tmux pane

alias sudoer='sudo -s /bin/zsh'                         # Become sudo with zsh
alias mdedit='open -a MacDown'                          # Edit markdown
alias vi='nvim'                                         # Always use `vi`
alias vim='nvim'                                        # Always use `vi`
alias nvim_rmswap='rm ~/.local/share/nvim/swap/*.swp'   # Remove all swp files
alias cat='bat'                                         # Use `bat` as default
alias diff='nvim -d '                                   # Use nvim to diff stuff
alias imcat='shellpic --shell24'                        # Use shellpic to display image previews
alias ql='qlmanage -p > /dev/null 2> /dev/null'         # Open file with macOS Quick-Look
alias xargs='xargs -I%'                                 # Use `%` as default `xargs` placeholder

unalias gcb                             # I don't care what this does, I want to use it myself
unalias gpu                             # This git plugin alias pushes to the upstream (it's f* dangerous)

alias gcb='git_current_branch'          # Display current branch
alias gdt='git difftool'                # Diff tool
alias gmt='git mergetool'               # Merge tool

alias vew='virtualenvwrapper'           # Quick virtualenvwrapper
alias mkve='mkvirtualenv'               # Create new virtual env
alias rmve='rmvirtualenv'               # Remove virtual env
alias lve='lsvirtualenv'                # List virtual envs
alias py='ipython'                      # Start ipython session
alias jn='jupyter notebook'             # Start jupyter notebook server
alias jl='jupyter lab'                  # Start jupyter lab server

# -----------------------
# EXTRA TOOLS

# Load `fasd`
eval "$(fasd --init auto)"
autoload -U compinit && compinit -U

# Set `ripgrep` config file
export RIPGREP_CONFIG_PATH="$HOME/.dotfiles/ripgreprc"

# Load `fzf` and define default options
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='-i --height 50% --border --inline-info '

# Load `git` + `fzf` additions
source ~/.dotfiles/zshrc.git.fzf

# `git` plugin custom extensions

# Add remote, fetch and checkout branch in a single command
# Parameters: $1: remote $2: branch name
gaco() {
    [ $# -ne 2 ] && (echo "Usage: gaco remote branch"; return 1)
    git remote set-branches --add $@
    git fetch $@
    git checkout $2
}

# Use lease when force-pushing
ggpf () {
    if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
        git push --force-with-lease origin "${*}"
    else
        [[ "$#" == 0 ]] && local b="$(git_current_branch)"
        git push --force-with-lease origin "${b:=$1}"
    fi
}

# Pull from the upstream remote
glu () {
    if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
        git pull upstream "${*}"
    else
        [[ "$#" == 0 ]] && local b="$(git_current_branch)"
        git pull upstream "${b:=$1}"
    fi
}

# Checkout a GH PR
# Assuming that `upstream` contains the original repo remote
function gcopr() {
    git fetch upstream pull/$1/head:pr-$1 && \
    git checkout pr-$1
}

# Use `gitignore.io` for default gitignore configurations
function gi() { curl -sL https://www.gitignore.io/api/$@ ;}

# Get the available gitignore.io types
function _gitignoreio_get_command_list() {
  curl -sL https://www.gitignore.io/api/list | tr "," "\n"
}

# Completion for the `gi` function
function _gitignoreio () {
  compset -P '*,'
  compadd -S '' `_gitignoreio_get_command_list`
}
compdef _gitignoreio gi

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

# pyenv init
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path -)"
    pyenv virtualenvwrapper
fi

# FUCK!
eval $(thefuck --alias)

# Purge the entire docker stuff
function docker_purge() {
    docker rm -f $(docker ps -aq)
    docker rmi -f $(docker images -aq)
    docker volume rm $(docker volume ls -q)
    docker system prune
}

# Set up completion for the `cheat` command
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
