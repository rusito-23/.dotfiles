# ----------- #
# ZSH CONFIGS #
# ----------- #
export TERM="xterm-256color"
ZSH_DISABLE_COMPFIX="true"
export ZSH=$HOME/.oh-my-zsh

# ------------------ #
# ZSH PLUGINS CONFIG #
# ------------------ #
# -- THEME --
ZSH_THEME="powerlevel9k/powerlevel9k"
# -- TMUX CONF --
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOCONNECT=false
# -- LIST --
plugins=(
	sudo
	git
	zsh-autosuggestions
	vi-mode
	zsh-syntax-highlighting
        virtualenv
        tmux
        tmux-cssh
)

# ----------- #
# ZSH SOURCES #
# ----------- #
source $HOME/.dotfiles/zsh/source/powerlevel.zsh
source $ZSH/oh-my-zsh.sh
source $HOME/.dotfiles/zsh/source/main.zsh

