#!/bin/sh
source $HOME/.dotfiles/zsh/source/dirs.zsh
source $ASSETS_DIR/colors.zsh

confirmWarning()
{
  echo " "
  echo "${BYellow}WARNING!${Color_Off}"
  echo "This script will require super use permissions"
  echo "and runs external scripts into your computer"

  while true; do
    read -p "Please confirm if you wish to continue, at your own risk ... (Y/n)" yn
    case $yn in
      [Yy]* ) echo "${BGreen}Pogram install will continue${Color_Off}";return 0;;
      [Nn]* ) exit;;
      * ) echo "Please answer Y/n.";;
    esac
  done

  return 1
}

linux_dependencies=("neofetch", "zsh", "Hack Nerd Font")
mac_dependencies=("neofetch", "zsh", "Hack Nerd Font", "wget")

# Curl for HackNerdFont
curlHackFont()
{
  curl -fLo "HackNerdFont.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf
  echo "${Yellow}HackNerdFont INSTALLED! ${Color_Off}Please select this as the default terminal font!"
}


# MARK: -- FUNCTIONS FOR SUPPORTED OS

# Requirements install for LINUX
linux()
{
  # generic requirements
  sudo apt-get update
  sudo apt-get install neofetch
  sudo apt-get install zsh

  # font requirements
  mkdir -p $FONTS_DIR_LINUX
  cd $FONTS_DIR_LINUX
  curlHackFont

  echo "${Green}Successfully installed linux Requirements!${Color_Off}"
}

# Requirements install for MACOS
macOS()
{
  # generics
  brew update
  brew install neofetch
  brew install wget

  # https://hackernoon.com/macbook-my-command-line-utilities-f8a121c3b019
  # utilities
  brew install fasd
  brew install peco
  brew install tig

  # font requirements
  cd $FONTS_DIR_MAC
  curlHackFont
  cd $HOME

  echo "${Green}Successfully installed macOS Requirements!${Color_Off}"
}

# print requirements
confirmRequirements()
{
  echo " "
  echo "${BYellow}WARNING!${Color_Off}"
  echo "This script will install the following requirements:"

  dependencies=("$@")
  for i in "${dependencies[@]}";
  do
    echo " $i "
  done

  while true; do
    read -p "Do you wish to continue the installation? ... (Y/n)" yn
    case $yn in
      [Yy]* ) echo "${BGreen}Pogram install will continue${Color_Off}";return 0;;
      [Nn]* ) exit;;
      * ) echo "Please answer Y/n.";;
    esac
  done

  return 1
}

# MARK: -- RECOGNIZE SUPPORTED OS

installDependencies()
{
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    confirmRequirements "${linux_dependencies[@]}"
    linux
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    confirmRequirements "${mac_dependencies[@]}"
    macOS
  fi
}

# MARK: -- INSTALL

install()
{
  # confirmWarning
  confirmWarning

  # install dependencies
  echo "${Purple}Installing dependencies:${Color_Off}"
  installDependencies

  # install oh-my-zsh
  echo "${Purple}Installing Oh-my-zsh:${Color_Off}"
  wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
  mv $HOME/.zshrc $HOME/.zshrc_viejo
  cp $ROOT_DIR/.zshrc $HOME/.zshrc # loading personal configuration!

  # install extra plugins and themes
  echo "${Purple}Installing and configuring extra plugins and themes:${Color_Off}"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $OH_MY_ZSH_DIR/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions/ $OH_MY_ZSH_DIR/plugins/zsh-autosuggestions
  git clone https://github.com/bhilburn/powerlevel9k.git $OH_MY_ZSH_DIR/custom/themes/powerlevel9k
  git clone https://github.com/esc/conda-zsh-completion ${OH_MY_ZSH_DIR}/plugins/conda-zsh-completion

  # set zsh as default
  echo "${Purple}Setting zsh as default shell:${Color_Off}"
  chsh -s $(which zsh)
  zsh

  echo "${BGreen}  INSTALLATION FINISHED SUCCESSFULLY!  ${Color_Off}"
}

install "${@}"
