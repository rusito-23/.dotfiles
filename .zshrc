# Load Zsh configs for interactive sessions.

source ~/.config/zsh/init.zsh
source ~/.config/zsh/keymaps.zsh
source ~/.config/zsh/plugin.zsh
source ~/.config/zsh/alias.zsh
source ~/.config/zsh/powerlevel.zsh
source ~/.config/zsh/functions.zsh

source ~/.config/zsh/fzf.git.zsh
source ~/.config/zsh/fzf.tools.zsh

# Load FZF completions and key-bindings
source /opt/homebrew/opt/fzf/shell/completion.zsh
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

for s in ~/.config/zsh/ignored/*.sh(N); source $s
