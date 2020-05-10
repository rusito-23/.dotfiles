#!/bin/sh

cp $HOME/.gitconfig $HOME/.gitconfig_old
mklink $HOME/.gitconfig $HOME/.dotfiles/git/.gitconfig

echo "DONE 🤟 "
