# Plugin Configuration
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/poetry", from:oh-my-zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "romkatv/powerlevel10k", as:theme

# Plugin evaluations
eval "$(thefuck --alias)"
eval "$(mise activate zsh)"
eval "$(fasd --init auto)"

# Plugin Configuration
export RIPGREP_CONFIG_PATH=~/.config/zsh/ripgreprc
export FZF_DEFAULT_OPTS='-i --height 50% --border --inline-info '

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
