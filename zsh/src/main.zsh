#!/bin/zsh
source $HOME/.dotfiles/zsh/src/dirs.zsh

# .ZSH CONFIGURATION
# AUX FILES
source $ASSETS_DIR/colors.zsh

# SECTIONS :

# : ALIAS
source $SOURCES_DIR/alias.zsh

# : INIT
source $SOURCES_DIR/init.zsh

# : Shell integration
source ~/.iterm2_shell_integration.zsh

# : PATHS (OPTIONAL)
if [ -f $SOURCES_DIR/paths.zsh ]; then
    source $SOURCES_DIR/paths.zsh
fi

# : CUSTOM (OPTIONAL)
if [ -f $SOURCES_DIR/custom.zsh ]; then
    source $SOURCES_DIR/custom.zsh
fi

# : VIRTUALENVWRAPPER (OPTIONAL)
if [ -f $SOURCES_DIR/python.zsh ]; then
    source $SOURCES_DIR/python.zsh
fi

# : FASD INITIALIZATION
if [ -f $SOURCES_DIR/fasd.zsh ]; then
    source $SOURCES_DIR/fasd.zsh
fi

# : GCLOUD INITIALIZATION
if [ -f $SOURCES_DIR/gcloud.zsh ]; then
    source $SOURCES_DIR/gcloud.zsh
fi

# : GIT
source $SOURCES_DIR/git.zsh

# : GOLANG INITIALIZATION
if [ -f $SOURCES_DIR/go.zsh ]; then
    source $SOURCES_DIR/go.zsh
fi



