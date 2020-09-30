# ZSH CONFIGS #
# ----------- #

export TERM="xterm-256color"
export ZSH=$HOME/.oh-my-zsh
ZSH_DISABLE_COMPFIX="true"

# PLUGINS CONFIG #
# -------------- #

ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOCONNECT=false

plugins=(
    sudo
    git
    zsh-autosuggestions
    vi-mode
    zsh-syntax-highlighting
    virtualenv
    tmux
    tmux-cssh
)

# POWERLEVEL CONFIG #
# ----------------- #

source $HOME/.dotfiles/.powerlevelrc

# OH MY ZSH #
# --------- #

source $ZSH/oh-my-zsh.sh

#  WELCOME MESSAGE  #
#  ---------------  #

if [[ -o login ]]; then
    echo "ПРИВЕТ СУКА БЛЯТЬ"
fi

#  SHELL INTEGRATION  #
# ------------------- #

if [ -f ~/.iterm2_shell_integration.zsh ]; then
    source ~/.iterm2_shell_integration.zsh
fi

#   IGNORED  #
# ---------- #

for s in $HOME/.dotfiles/.ignored/*; do source $s; done

#  QUICK SOURCE  #
#  ------------  #

alias src='source ~/.zshrc'

#  NAVIGATION  #
#  ----------  #

setopt noautoremoveslash
alias ls='ls -GFh'
alias l='ls'
alias la='ls -a'
alias ll='ls -FGLAhp'
alias ldir='ls -d'
alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../../'

#      TMUX        #
# ---------------- #

alias tmuxx='tmux source-file ~/.tmux.conf'
# set unset tmux for nested sessions
alias unsetmux='OLD_TMUX=$TMUX;TMUX=""'
alias resetmux='TMUX=$OLD_TMUX'

#   PATHS  #
# -------- #

export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/bin:$PATH

#       FASD       #
# ---------------- #

eval "$(fasd --init auto)"
autoload -U compinit && compinit -U

#     RIPGREP      #
# ---------------- #
export RIPGREP_CONFIG_PATH="$HOME/.dotfiles/.ripgreprc"

#        FZF       #
# ---------------- #

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='-i --height 50% --border --inline-info '

#    FZF + TMUX    #
alias fr='fzf-tmux -r 60'
alias fl='fzf-tmux -l 60'

# ---------------- #
# GIT + FZF PLUGIN #
# Taken and modified from:
# https://junegunn.kr/2016/07/fzf-git
# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
# ---------------- #

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

# FILES #
fzf_gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

# BRANCHES #
fzf_go() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf --ansi --multi --tac --preview-window right:50% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

# TAGS #
fzf_gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf --multi --preview-window right:50% \
    --preview 'git show --color=always {} | head -'$LINES
}

# COMMIT HASHES #
fzf_gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

# REMOTES #
fzf_gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

# GIT FZF KEY BINDINGS
# --------------------

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


#  SUDOER ALIAS  #
# -------------- #

alias sudoer='export ITERM_PROFILE=rusito23-zshrc ;sudo -s /bin/zsh'

# EDITION #
# ------- #

alias mdedit='open -a MacDown'
alias vi='nvim'
alias vim='nvim'
alias nvim_rmswap='rm ~/.local/share/nvim/swap/*.swp'
alias cat='bat'
alias diff='nvim -d '

# NETWORK #
# ------- #

alias myip='ifconfig |grep inet'

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


# GIT PLUGIN EXTENSION #
# -------------------- #

github() { git clone https://github.com/$1.git $2 ;}
bitbucket() { git clone https://bitbucket.org/$1.git $2 ;}

# fetch and checkout branch in a single command
gfco() { git fetch origin $@ ; git checkout $@ ;}

# get current branch name
unalias gcb
alias gcb='git_current_branch'

# diff and mergetools
alias gdt='git difftool'
alias gmt='git mergetool'

# don't git push force, git push force with lease!
ggpf () {
    if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]
    then
        git push --force-with-lease origin "${*}"
    else
        [[ "$#" == 0 ]] && local b="$(git_current_branch)"
        git push --force-with-lease origin "${b:=$1}"
    fi
}

# CHECKOUT FEATURE - FIX

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

#        GO        #
# ---------------- #

# GO VERSION MANAGER
(( ${+aliases[g]} )) && unalias g
export GOPATH="$HOME/go";
export GOROOT="$HOME/.go";
export PATH="$GOPATH/bin:$PATH";


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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
