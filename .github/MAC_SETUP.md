# Mac Set up

## Menu bar

```
defaults write NSGlobalDomain _HIHideMenuBar -bool true                 # Enable autohide
defaults write com.apple.menuextra.battery ShowPercent -bool true       # Show battery percentage
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist BatteryShowPercentage -bool true
```

## Finder

```
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true              # Show file path
defaults write com.apple.finder ShowStatusBar -bool true                        # Show status bar
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false     # Don't show stuff in my desktop
```

## Dock

```
defaults write com.apple.dock autohide -bool true               # Enable autohide
defaults write com.apple.dock autohide-delay -int 0             # Disable autohide delay
defaults write com.apple.dock static-only -bool true            # Show only active apps
defaults write com.apple.dock tilesize -integer 24              # Set normal size
defaults write com.apple.dock largesize -int 128                # Set magnified size
defaults write com.apple.dock mru-spaces -bool false            # Disable auto arrangement
```

## Window Manager

```
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop 0
```

## Sound Quality

```
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
```

## Hot corners

```
defaults write com.apple.dock wvous-br-corner -int 5            # Bottom right → Start screen saver
defaults write com.apple.dock wvous-br-modifier -int 0          # Bottom right modifier → None
```

## Set up pam sudo reattach

```
brew install fabianishere/personal/pam_reattach         # Workaround to enable for tmux
sudo bash -c 'echo -e "auth  sufficient  pam_tid.so\n$(cat /etc/pam.d/sudo)" > /etc/pam.d/sudo'
sudo bash -c 'echo -e "auth  optional    pam_reattach.so\n$(cat /etc/pam.d/sudo)" > /etc/pam.d/sudo'
```

## Screenshots

```
mkdir -p ~/Documents/screenshots
defaults write com.apple.screencapture location ~/Documents/screenshots
```

