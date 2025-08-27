# zprofile
# Configuration for all sessions.

# {{{ Configuration

export TERM="xterm-256color"
export VISUAL=nvim
export EDITOR=nvim
export PAGER=less
export LESS=-FRX

# }}}

# {{{ Path Setup


export PATH=$HOME/.local/bin:$PATH
export PATH=/usr/local/bin:$PATH

BREW_PREFIX=/opt/homebrew
export PATH=$PATH:$BREW_PREFIX/bin
export PATH=$PATH:$BREW_PREFIX/sbin
export PATH=$PATH:$BREW_PREFIX/opt
export PATH=$PATH:$BREW_PREFIX/opt/fzf/bin

# }}}
