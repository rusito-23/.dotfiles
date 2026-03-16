# Keymaps

# Auto-delete the ˜ char
bindkey ˜ delete-char

# Disable vi mode
bindkey -e

# Word selection configuration
export WORDCHARS='*_-.[]~;!$%^(){}<>'       # Defines word delimiters
autoload -Uz select-word-style
select-word-style normal                    # Redefine word style

# Cycle through auto suggestions with up/down
if [[ "${terminfo[kcuu1]}" != "" ]]; then
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-sear
    bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
if [[ "${terminfo[kcud1]}" != "" ]]; then
    autoload -U down-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# Bind Ctrl-K to launch Claude in continue mode
_launch_cc() {
  BUFFER="claude --continue"
  zle accept-line
}
zle -N _launch_cc
bindkey '^K' _launch_cc

# Bind Ctrl-F to foreground the most recent background job
_launch_fg() {
  BUFFER="fg"
  zle accept-line
}
zle -N _launch_fg
bindkey '^F' _launch_fg
