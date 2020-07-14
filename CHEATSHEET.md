# CHEATSHEET

## iTerm mappings

| KEYS | MAPPING | HEX | But why? |
| --- | --- | --- | --- |
| CMD+L | ^L | 0x0C | clear |
| CMD+D | ^D | 0x04 | exit |
| CMD+B | ^B | 0x02 | tmux prefix |
| CMD+P | ^P | 0x10 | CtrlP vim plugin |
| CMD+G | ^G | 0x07 | fzf + git plugin prefix |
| CMD+O | ^O | 0x0F | fzf + git plugin branches |
| CMD+H | ^H | 0x08 | fzf + git plugin hashes |
| CMD+F | ^F | 0x06 | fzf + git plugin files |
| CMD+T | ^T | 0x14 | fzf + git plugin tags |

## vim

| SHORTCUT | ACTION |
| --- | --- |
| C-n | Toggle NERDTree |
| C-t | Toggle Tagbar |
| C-p | Ctrl P |
| q | Record macro |
| SPACE | Play macro named **q** |
| \<leader\>q | :q |
| \<leader\>a | :qa! |
| \<leader\>s | :w |
| \<leader\>cc | comment |
| \<leader\>e | fzf files |
| \<leader\>f | fzf code in file |
| \<leader\>F | fzf code in all files |
| \<leader\>c | fzf vim commands |
| \<leader\>b | list buffers |
| \<leader\>bd | remove current buffer |

### :warning: WARNING:
`x-d-D-dd` commands **delete** the selected text - to **cut** use `<leader>-x-d-D-dd` (leader is ',')

## tmux

| SHORTCUT | ACTION |
| --- | --- |
| **prefix**-D | Safe dettach |
| unsetmux | unset $TMUX |
| resetmux | reset $TMUX |
| M-c | Create new window |
| M-n | Move to next window |
| M-p | Move to previous window |
| C-a | Send prefix to nested session |
| **prefix**-R | Reload config |
| **prefix**-$ | Rename session |
| **prefix**-: | Send command |
| **prefix**-% | Create vertical pane |
| **prefix**-" | Create horizontal pane |

## OhMyZsh Tmux Plugin aliases ([plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux))

| Alias  | Command                | Description                                               |
| ------ | -----------------------|---------------------------------------------------------- |
| `ta`   | tmux attach -t         | Attach new tmux session to already running named session  |
| `tad`  | tmux attach -d -t      | Detach named tmux session                                 |
| `ts`   | tmux new-session -s    | Create a new named tmux session                           |
| `tl`   | tmux list-sessions     | Displays a list of running tmux sessions                  |
| `tksv` | tmux kill-server       | Terminate all running tmux sessions                       |
| `tkss` | tmux kill-session -t   | Terminate named running tmux session                      |
| `tmux` | `_zsh_tmux_plugin_run` | Start a new tmux session                                  |

## commons

| SHORTCUT | ACTION |
| --- | --- |
| M-. | Create Vertical Pane |
| M-, | Create Horizontal Pane |
| M-vim-keys | Switch Pane |


## SSH Cheatsheets

### Install package (no root)

**$PATH** must include `$HOME/.local/bin`

```
apt-get download package
dpkg -x package.deb folder
mv folder/usr/bin ~/.local/bin
```
