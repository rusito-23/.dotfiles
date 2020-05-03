#!/bin/zsh
source $HOME/.dotfiles/zsh/src/dirs.zsh

# .ZSH CONFIGURATION
# AUX FILES
source $ASSETS_DIR/colors.zsh

# : ALIAS
source $SOURCES_DIR/alias.zsh

# : INIT MESSAGE
source $SOURCES_DIR/init.zsh

# : Shell integration
source ~/.iterm2_shell_integration.zsh

# : VIRTUALENVWRAPPER (OPTIONAL)
source $SOURCES_DIR/python.zsh

# : FASD INITIALIZATION
source $SOURCES_DIR/fasd.zsh

# : GCLOUD INITIALIZATION
source $SOURCES_DIR/gcloud.zsh

# : GIT
source $SOURCES_DIR/git.zsh

# : GOLANG INITIALIZATION
source $SOURCES_DIR/go.zsh

# : AUTOSUGGESTIONS CONFIG
source $SOURCES_DIR/autosuggestions.zsh

# : TMUX UTILS
source $SOURCES_DIR/tmux.zsh

# : IGNORED
for s in $SOURCES_DIR/ignored/*; do source $s; done


