# Custom Zsh functions

# {{{ ggpf

# Use lease when force-pushing
ggpf () {
    if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
        git push --force-with-lease origin "${*}"
    else
        [[ "$#" == 0 ]] && local b="$(git_current_branch)"
        git push --force-with-lease origin "${b:=$1}"
    fi
}

# }}}

# {{{ gi

# Use `gitignore.io` for default gitignore configurations
function gi() { curl -sL https://www.gitignore.io/api/$@ ;}

# Get the available gitignore.io types
function _gitignoreio_get_command_list() {
  curl -sL https://www.gitignore.io/api/list | tr "," "\n"
}

# Completion for the `gi` function
function _gitignoreio () {
  compset -P '*,'
  compadd -S '' `_gitignoreio_get_command_list`
}
compdef _gitignoreio gi

# }}}
