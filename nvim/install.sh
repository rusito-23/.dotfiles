#!/bin/sh

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Install DEIN

echo "${Cyan}Installing dein >>> "

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > dein_installer.sh
sh ./dein_installer.sh ~/.dotfiles/nvim/dein
rm dein_installer.sh

# Install python dependencies

echo "${Cyan}Installing python dependencies >>> "

pip install -r ~/.dotfiles/nvim/requirements.txt

# Source file

echo "${Cyan}Source nvimrc from nvim/init.vim >>> "

echo 'source ~/.dotfiles/nvim/.nvimrc' > ~/.config/nvim/init.vim

# Finish

echo "${Green}Setup successfull! >>>"
echo "${Purple}Please remember to run 'call dein#install()' when running nvim"

