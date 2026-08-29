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

## Setup

| Script | Use on | Bare repo |
| --- | --- | --- |
| `.config/setup/setup` | macOS, full machine | Yes |
| `.config/setup/mac_setup` | macOS, full machine | No |
| `.config/setup/pi_setup` | Raspberry Pi / servers | No (clones the `pi` branch) |
| `.config/setup/docker_minimal_setup <container>` | Docker containers | Yes, on host |
