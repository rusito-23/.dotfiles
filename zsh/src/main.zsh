#!/bin/zsh
source $HOME/.dotfiles/zsh/src/dirs.zsh

# LOAD AUX FILES
source $ASSETS_DIR/colors.zsh

# SHELL INTEGRATION
if [ -f $SOURCES_DIR/custom.zsh ]; then
    source ~/.iterm2_shell_integration.zsh
fi

# : INIT
source $SOURCES_DIR/init.zsh

# : IGNORED
for s in $SOURCES_DIR/ignored/*; do source $s; done

# : SOURCES
for s in $SOURCES_DIR/sources/*; do
    echo $s;
    source $s;
done
