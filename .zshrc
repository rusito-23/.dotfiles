
# ███████╗███████╗██╗  ██╗
# ╚══███╔╝██╔════╝██║  ██║
#   ███╔╝ ███████╗███████║
#  ███╔╝  ╚════██║██╔══██║
# ███████╗███████║██║  ██║
# ╚══════╝╚══════╝╚═╝  ╚═╝
# Minimal zsh config for servers and places where you can't install much
# stuff. Assumes Oh My Zsh + zsh-autosuggestions + zsh-syntax-highlighting
# are installed (see .config/setup/pi_setup)

# ------------------------------
# Oh My Zsh

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# zsh-syntax-highlighting must stay last
plugins=(git sudo docker zsh-autosuggestions zsh-syntax-highlighting)

source "$ZSH/oh-my-zsh.sh"

# ------------------------------
# History

setopt share_history
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_reduce_blanks

# ------------------------------
# Word navigation

export WORDCHARS='*_-.[]~;!$%^(){}<>'
autoload -Uz select-word-style
select-word-style normal

# Foreground the most recent background job with Ctrl-F
_launch_fg() {
  BUFFER="fg"
  zle accept-line
}
zle -N _launch_fg
bindkey '^F' _launch_fg

# ------------------------------
# Git alias overrides (OMZ's git plugin gcb/gpu are unwanted defaults)

unalias gcb 2>/dev/null
unalias gpu 2>/dev/null
alias gcb='git_current_branch'
alias gs='git status --ignore-submodules -s'

# ------------------------------
# General aliases

alias src='source ~/.zshrc'
alias ls='ls -GFh'
alias ll='ls -lh'
alias la='ls -a'
alias vi='nvim'
alias vim='nvim'
alias diff='nvim -d'
alias xargs='xargs -I%'
alias now='date +%d.%m.%y-%H:%M:%S'

# ------------------------------
# bat (Debian packages it as `batcat`)

if command -v bat &> /dev/null; then
  alias cat='bat'
elif command -v batcat &> /dev/null; then
  alias cat='batcat'
fi

# ------------------------------
# fzf

[[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[[ -f /usr/share/doc/fzf/examples/completion.zsh ]] && source /usr/share/doc/fzf/examples/completion.zsh
export FZF_DEFAULT_OPTS='-i --height 50% --border --inline-info'
