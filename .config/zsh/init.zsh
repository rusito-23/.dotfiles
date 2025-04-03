# Main Configuration

# Definitions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
ZSH_DISABLE_COMPFIX="true"

# General options
setopt noautoremoveslash                    # Keep the trailing slash
bindkey ˜ delete-char                       # Auto-delete the ˜ char
touch ~/.hushlogin                      # Disable login message

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

# Load Completions
autoload -U compinit && compinit -U

