# ZSH CONFIGS #
# ----------- #

ZSH_DISABLE_COMPFIX="true"

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
