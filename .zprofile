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
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/opt/homebrew/opt/fzf/bin:$PATH

# }}}

# {{{ Welcome

# Display welcome message
[[ -o login ]] && echo "ДОБРО ПОЖАЛОВАТЬ, РУСИТО 23!\n"

# }}}
