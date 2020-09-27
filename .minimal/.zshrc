#  ZSH INIT  #
#  --------  #

ZSH_DISABLE_COMPFIX="true"

#  TMUX INIT  #
#  ---------  #

if [ "$TMUX" = "" ]; then tmux; fi

#  COMPLETION  #
#  ----------  #

autoload -Uz compinit''']]}]]}'''''''
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
compinit -u

#  VCS  #
#  ---  #

# load vc info
autoload -Uz vcs_info
precmd() { vcs_info }

#  PROMPT  #
#  ------  #
setopt PROMPT_SUBST

# vcs info format
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' actionformats '(%b) %F{red}(%a)%F{cyan} %u%c'
zstyle ':vcs_info:*' formats '(%b) %u%c%m'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == 'true' ]] && \
        git status --porcelain | grep -m 1 '^??' &>/dev/null
    then
        hook_com[misc]='?'
    fi
}

# left prompt
# $(working_dir) ($(git_info)) $(% if user # if root)
PROMPT='%B%F{240}%1~ %F{cyan}%b${vcs_info_msg_0_}%f%b %# '

# right prompt
# $(green √ if sucess red ? if error)
RPROMPT='%(?.%F{green}√.%F{red}?%?)%f'

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


#  EDITION  #
#  -------  #

alias vi='vim'
alias diff='vimdiff'

#                                     GIT                                     #
#  https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh  #
#  -------------------------------------------------------------------------  #

alias g='git'
alias gc='git commit -v'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gco='git checkout'
alias gd='git diff'
alias gdt='git difftool'
alias gcp='git cherry-pick'
alias glo='git log --oneline --decorate'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias gm='git merge'
alias gmt='git mergetool'
alias grb='git rebase'
alias gss='git status -s'
alias gst='git status'

function git_current_branch() {
    git rev-parse --abbrev-ref HEAD
}

function ggl() {
if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git pull origin "${*}"
else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git pull origin "${b:=$1}"
fi
}
compdef _git ggl=git-checkout

function ggp() {
if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push origin "${*}"
else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git push origin "${b:=$1}"
fi
}
compdef _git ggp=git-checkout

#  IGNORED  #
#  -------  #

for s in $HOME/.dotfiles/.ignored/*; do source $s; done

#  WELCOME MESSAGE  #
#  ---------------  #

if [[ -o login ]]; then
    echo "ПРИВЕТ СУКА БЛЯТЬ"
fi
