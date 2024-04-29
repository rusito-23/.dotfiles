# dotfiles :nerd_face:

```shell
git clone --bare git@github.com:rusito-23/.dotfiles.git .dotfiles.git
```

```shell
alias dot='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
```

```shell
dot config --local status.showUntrackedFiles no
```
