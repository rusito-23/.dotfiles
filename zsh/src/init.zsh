#!/bin/zsh
source $HOME/.dotfiles/zsh/src/dirs.zsh

# ----------------------------------------------------------------------------
# EXECUTE ON STARTUP 
# ----------------------------------------------------------------------------


if [[ -o login ]]; then

  SUDOER=$ASSETS_DIR/sudoer_welcome

  # WELCOME MESSAGE
  # ---------------

  colors=($BRed $BBlue $BCyan $BYellow $BGreen $BPurple)
  # seed random generator
  RANDOM=$$$(date +%s)
  # pick a random entry from the domain list to check against
  random_color=${colors[$RANDOM % ${#colors[@]}]}
  echo -e "$random_color"
  if [ $(id -u) = "0" ]; then
      cat $SUDOER
  else
      echo "ПРИВЕТ СУКА БЛЯТЬ"
  fi
  echo -e "$Color_Off"

fi


