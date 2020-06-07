#!/bin/sh

cp $HOME/.gitconfig $HOME/.gitconfig_old
ln -s $HOME/.dotfiles/git/.gitconfig $HOME/.gitconfig 

echo "DONE 🤟 "
