#!/bin/zsh
source $HOME/.dotfiles/zsh/src/dirs.zsh

# .ZSH CONFIGURATION

# AUX FILES
source $ASSETS_DIR/colors.zsh
source ~/.iterm2_shell_integration.zsh

# : INIT
source $SOURCES_DIR/init.zsh

# : SOURCES
for s in $SOURCES_DIR/sources/*; do source $s; done

# : IGNORED
for s in $SOURCES_DIR/ignored/*; do source $s; done
