# Keymaps

# Auto-delete the ˜ char
bindkey ˜ delete-char

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
