
#  ________  .______   .______        ______    _______  __   __       _______
# |       /  |   _  \  |   _  \      /  __  \  |   ____||  | |  |     |   ____|
# `---/  /   |  |_)  | |  |_)  |    |  |  |  | |  |__   |  | |  |     |  |__
#    /  /    |   ___/  |      /     |  |  |  | |   __|  |  | |  |     |   __|
#   /  /----.|  |      |  |\  \----.|  `--'  | |  |     |  | |  `----.|  |____
#  /________|| _|      | _| `._____| \______/  |__|     |__| |_______||_______|
# Configuration for all sessions.

# {{{ Configuration

export TERM="xterm-256color"
export VISUAL=nvim
export EDITOR=nvim
export PAGER=less
export LESS=-FRX

# }}}

# {{{ Path Setup

export PATH=$HOME/.mint/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.rvm/bin:$PATH
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
export PATH=/usr/local/bin:$PATH

# }}}

# {{{ Welcome

# Display welcome message
[[ -o login ]] && echo "ПРИВЕТ СУКА БЛЯТЬ"

# }}}
