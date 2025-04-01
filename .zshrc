
# ███████╗███████╗██╗  ██╗██████╗  ██████╗
# ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#   ███╔╝ ███████╗███████║██████╔╝██║
#  ███╔╝  ╚════██║██╔══██║██╔══██╗██║
# ███████╗███████║██║  ██║██║  ██║╚██████╗
# ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝
# Configuration for interactive sessions.

# {{{ General Configuration

export ZSH=$HOME/.oh-my-zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
ZSH_DISABLE_COMPFIX="true"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Word Selection Configuration
export WORDCHARS='*_-.[]~;!$%^(){}<>'
autoload -Uz select-word-style
select-word-style normal

plugins=(
    sudo
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    virtualenv
    virtualenvwrapper
    tmux
    tmux-cssh
    docker
    docker-compose
    calc
    kubectl
    poetry
)

source $HOME/.powerlevelrc
source $ZSH/oh-my-zsh.sh

INSTANT_PROMPT="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
if [[ -r INSTANT_PROMPT ]]; then source INSTANT_PROMPT fi

# General options
setopt noautoremoveslash
bindkey ˜ delete-char           # Auto-delete the ˜ char

# {{{ Cycle through auto suggestions with up/down

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

# }}}

# }}}

# {{{ Alias

# General purpose

alias src='source ~/.zshrc'     # Quick reload
alias sudoer='sudo -s /bin/zsh'                         # Become sudo with zsh
alias imcat='shellpic --shell24'                        # Use shellpic to display image previews
alias ql='qlmanage -p > /dev/null 2> /dev/null'         # Open file with macOS Quick-Look
alias xargs='xargs -I%'                                 # Use `%` as default `xargs` placeholder
alias t='tmux'                                          # With great power comes great responsibility
alias now='date +%d.%m.%y-%H:%M:%S'                     # The current date and time, use wisely!
alias mk='make'                                         # Just me being really lazy so what

# Navigation

alias ls='ls -GFh'              # Default ls config
alias ll='ls -lh'               # Long list command
alias la='ls -a'                # Hidden files
alias cd..='cd ../'             # Fix common typo
alias ..='cd ../'               # Navigate with dots
alias ...='cd ../../'           # Navigate with dots

# Tmux

alias unsetmux='OLD_TMUX=$TMUX;TMUX=""'         # Enable nested tmux sessions
alias resetmux='TMUX=$OLD_TMUX'                 # Disable nested tmux sessions

alias fr='fzf-tmux -r 60'               # Start fzf in a right tmux pane
alias fl='fzf-tmux -l 60'               # Start fzf in a left tmux pane

# Edition

alias mdedit='open -a MacDown'                          # Edit markdown
alias vi='nvim'                                         # Always use `vi`
alias vim='nvim'                                        # Always use `vi`
alias nvim_rmswap='rm ~/.local/share/nvim/swap/*.swp'   # Remove all swp files
alias cat='bat'                                         # Use `bat` as default
alias diff='nvim -d '                                   # Use nvim to diff stuff

# Git

unalias gcb                             # I don't care what this does, I want to use it myself
unalias gpu                             # This git plugin alias pushes to the upstream (it's f* dangerous)

alias gcb='git_current_branch'                # Display current branch
alias gdt='git difftool -y'                   # Diff tool
alias gmt='git mergetool'                     # Merge tool
alias gs='git status --ignore-submodules -s'  # Quick git status

# Bare Dotfiles

alias dot='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias dss='dot status --short'
alias da='dot add'
alias dcmsg='dot commit -m'
alias ddp='dot push origin main'

# Python

alias vew='virtualenvwrapper'           # Quick virtualenvwrapper
alias mkve='mkvirtualenv'               # Create new virtual env
alias rmve='rmvirtualenv'               # Remove virtual env
alias lve='lsvirtualenv'                # List virtual envs
alias py='ipython'                      # Start ipython session
alias jn='jupyter notebook'             # Start jupyter notebook server
alias jl='jupyter lab'                  # Start jupyter lab server

# Kubernetes
alias kcscn="kcsc --current --namespace" # I don't wanna write -n <namespace> every time

# Network Utils
alias ipv4="curl 'https://api.ipify.org'"
alias ipv6="curl 'https://api6.ipify.org'"

# }}}

# {{{ Plugin Configuration

# Completions
autoload -U compinit && compinit -U

# Ripgrep Configuration
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Fzf Configuration
[ -f ~/.dotfiles/fzf.zsh ] && source ~/.dotfiles/fzf.zsh
export FZF_DEFAULT_OPTS='-i --height 50% --border --inline-info '

# Load `git` + `fzf` additions
source ~/.dotfiles/fzf.git.zsh
source ~/.dotfiles/back.tools.zsh

# Plugin evaluations
eval $(thefuck --alias)
eval $(mise activate zsh)

# }}}

# {{{ Functions

# {{{ git plugin custom extensions

# Use lease when force-pushing
ggpf () {
    if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
        git push --force-with-lease origin "${*}"
    else
        [[ "$#" == 0 ]] && local b="$(git_current_branch)"
        git push --force-with-lease origin "${b:=$1}"
    fi
}

# Use `gitignore.io` for default gitignore configurations
function gi() { curl -sL https://www.gitignore.io/api/$@ ;}

# }}}

# }}}

# {{{ Custom Completions

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

# Set up completion for the `cheat` command
function _cheat_get_list() {
    ls ~/.cheatsheets | \
        awk -F. '{print $1}' | \
        tr '[:upper:]' '[:lower:]'
}
function _cheat() {
    compset -P '*,'
    compadd -S '' `_cheat_get_list`
}
compdef _cheat cheat

# }}}
