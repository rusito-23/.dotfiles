# Plugin Configuration - Using Zinit (faster than zplug)
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

# Load OMZ plugins
zinit snippet OMZP::sudo
zinit snippet OMZP::git
zinit snippet OMZP::docker
zinit snippet OMZP::kubectl
zinit snippet OMZP::poetry

# Load completions
zinit light gradle/gradle-completion

# Load zsh plugins (with turbo mode for speed)
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Load theme
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Plugin evaluations - lazy loaded for performance
# Lazy-load thefuck
fuck() {
  unfunction fuck
  eval "$(thefuck --alias)"
  fuck "$@"
}

# Lazy-load mise
mise() {
  unfunction mise
  eval "$(mise activate zsh)"
  mise "$@"
}

# Lazy-load fasd
if command -v fasd &> /dev/null; then
  fasd_cd() {
    if [ $# -le 1 ]; then
      command fasd "$@"
    else
      local _fasd_ret="$(command fasd -e 'printf %s' "$@")"
      [ -d "$_fasd_ret" ] && cd "$_fasd_ret" || printf %s\\n "$_fasd_ret"
    fi
  }
  alias z='fasd_cd -d'
  alias v='fasd -f -e nvim'
  alias o='fasd -a -e open'

  # Initialize fasd on first use
  _fasd_preexec() {
    unfunction _fasd_preexec
    eval "$(fasd --init auto)"
  }
  autoload -U add-zsh-hook
  add-zsh-hook preexec _fasd_preexec
fi

# Plugin Configuration
export RIPGREP_CONFIG_PATH=~/.config/zsh/ripgreprc
export FZF_DEFAULT_OPTS='-i --height 50% --border --inline-info '

