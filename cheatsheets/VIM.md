# Vim Cheat-sheet

## Shortcuts

| Mode | Shortcut | Description |
| --- | --- | --- |
| `N` | `f<char>` | Jump to next char |
| `N` | `F<char>` | Jump to previous char |
| `N` | ⌃`v` | Start visual block |
| `V-B` | `g`, ⌃`A` | Auto-increment visual block |
| `N` | ⌃`O` | Jump back to the previous location |
| `N` | ⌃`I` | (same as Tab) to jump forward to the next location |

## ⌃ Shortcuts

| Shortcut | Description |
| --- | --- |
| ⌃`N` | Toggle NerdTree |
| ⌃`T` | Toggle TagBar |
| ⌃`W` + `hjkl` | Navigate panes |
| ⌃`W` + ^`F` | Omni file completion |
| ⌃`P` | Regular completion |
| ⌃`D` | Scroll down really fast |
| ⌃`U` | Scroll up really fast |

## ⌥ Shortcuts

| Shortcut | Description |
| --- | --- |
| ⌥`.` | Create vertical split |
| ⌥`,` | Create horizontal split |
| ⌥`(hjkl)` | Move between splits |

## `<leader>` (`,`) Shortcuts

| Shortcut | Description |
| --- | --- |
| `<leader>s` | Save file |
| `<leader>w` | Activate window mode (⌃`W`) |
| `<leader>t` | Open terminal |
| `<leader>cc` | Comment line |
| `<leader>cu` | Uncomment line |

## Macro Shortcuts

| Shortcut | Description |
| --- | --- |
| `<q>` | Record macro |
| `<Space>` | Run macro named `q` |

## `telescope` Shortcuts

| Shortcut | Description |
| --- | --- |
| `<leader>e` | Find file |
| `<leader>f` | Find in current file |
| `<leader>b` | Find buffers |
| `<leader>F` | Live grep |
| `<leader>H` | List help tags |

### While searching on `telescope`

| Shortcut | Description |
| --- | --- |
| ⌃`D` | Delete buffer |
| ⌃`T` | Open in new tab |
| ⌃`J` | Navigate down |
| ⌃`K` | Navigate up |

## LSP Shortcuts

| Shortcut | Description |
| --- | --- |
| K | Show information |
| gd | Go to Definition |
| gr | List references |
| <C-k> | Show arguments |
| rr | Rename symbol |
| gl | Show diagnostics |
| [d | Next diagnostic |
| ]d | Previous diagnostic |

## Folds Cheatsheet

| Shortcut | Description |
| --- | --- |
| `zf#j` | Create a folder from the cursor down _#_ lines |
| `zj` | Moves the cursor to the next fold |
| `zk` | Moves the cursor to the previous fold |
| `zo` | Close the current fold at the cursor |
| `zo` | Opens a fold at the cursor |
| `zO` | Opens all folds at the cursor |
| `zm` | Increases the foldlevel by one |
| `zM` | Closes all open folds |
| `zr` | Decreases the foldlevel by one |
| `zR` | Decreases the foldlevel to zero -- all folds will be open |
| `zd` | Deletes the fold at the cursor |
| `zE` | Deletes all folds |
| `[z` | Move to start of open fold |
| `]z` | Move to end of open fold |
