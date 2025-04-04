# Main Configuration

# Definitions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
ZSH_DISABLE_COMPFIX="true"

# Options
setopt share_history           # Share history across sessions
setopt hist_ignore_all_dups    # Remove all duplicates
setopt hist_find_no_dups       # Don't show duplicates in search
setopt hist_expire_dups_first  # Expire old duplicates first
setopt hist_ignore_space       # Ignore commands starting with a space
setopt hist_ignore_dups        # Ignore consecutive duplicates
setopt hist_save_no_dups       # Don't save duplicate commands
setopt hist_reduce_blanks      # Trim extra spaces before saving
setopt noautoremoveslash       # Keep the trailing slash

# Load Completions
autoload -U compinit && compinit -U

