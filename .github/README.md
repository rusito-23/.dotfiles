# dotfiles :nerd_face:

```shell
git clone --bare git@github.com:rusito-23/.dotfiles.git ~/.dotfiles.git
alias dot='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
dot config --local status.showUntrackedFiles no
dot checkout main
```

## Setup

| Script | Use on | Bare repo |
| --- | --- | --- |
| `.config/setup/setup` | macOS, full machine | Yes |
| `.config/setup/mac_setup` | macOS, full machine | No |
| `.config/setup/docker_minimal_setup <container>` | Docker containers | Yes, on host |

Raspberry Pi / servers: same flow, but clone the `pi` branch (`-b pi`), then
run `.config/setup/pi_setup` — see that branch's README.
