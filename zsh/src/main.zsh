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

# : PATHS (OPTIONAL)
if [ -f $SOURCES_DIR/paths.zsh ]; then
    source $SOURCES_DIR/paths.zsh
fi

# : CUSTOM (OPTIONAL)
if [ -f $SOURCES_DIR/custom.zsh ]; then
    source $SOURCES_DIR/custom.zsh
fi

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
