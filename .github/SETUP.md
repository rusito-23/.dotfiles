# Set up

## SSH

```
ssh-keygen
```

## Homebrew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```
 # Install brew dependencies
while read p; do
  brew install "$p"
done <~/.dotfiles/requirements/brew-reqs.txt

# Install cask dependencies
while read p; do
  brew install cask "$p"
done <~/.dotfiles/requirements/cask-reqs.txt
```

## Clone

```
git clone --bare git@github.com:rusito-23/.dotfiles.git .dotfiles
```

```
git config --local status.showUntrackedFiles no
```

## Oh My Zsh

```
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
```

## Oh My Zsh Plugins

```
while read plugin; do
  gh_path=$(echo $plugin | cut -d ' ' -f 1)
  dst_path=$(echo $plugin | cut -d ' ' -f 2)
  git clone --depth=1 https://github.com/$gh_path ~/.oh-my-zsh/custom/plugins/$dst_path
done <~/.requirements/zsh-plugins.txt
```

## Powerlevel 10k

```
git clone --depth=1 \
    https://github.com/romkatv/powerlevel10k.git \
    ~/.oh-my-zsh/custom/plugins/powerlevel10k
```

## FZF

```
brew install fzf
```

```
$(brew --prefix)/opt/fzf/install
```

## Yabai

```
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
```

```
yabai --start-service
skhd --start-service
```

## Espanso

```
brew tap federico-terzi/espanso
brew install espanso
espanso register
```

## Fonts

```
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```

## Zsh

```
chsh -s $(which zsh)
```
