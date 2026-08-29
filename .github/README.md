# dotfiles :nerd_face: (pi branch)

Minimal config for Raspberry Pi / servers. Full macOS setup lives on `main`.

```shell
git clone --bare -b pi git@github.com:rusito-23/.dotfiles.git ~/.dotfiles.git
alias dot='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
dot config --local status.showUntrackedFiles no
dot checkout pi
```

Then run `.config/setup/pi_setup`.
