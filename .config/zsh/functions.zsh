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

# {{{ cheat

function _cheat_get_list() {
    ls ~/.cheatsheets | \
        awk -F. '{print $1}' | \
        tr '[:upper:]' '[:lower:]'
}
function _cheat() {
    compset -P '*,'
    compadd -S '' `_cheat_get_list`
}
compdef _cheat cheat

# }}}

# {{{ ssh

# Show the target host in the kitty tab while connected.
# Heuristic: takes the first non-flag argument, so `ssh -p 2222 host` is
# misread as host="2222" - fine for the common `ssh host`/`ssh user@host` case.
ssh() {
    local host
    for arg in "$@"; do
        [[ "$arg" == -* ]] && continue
        host="${arg#*@}"
        break
    done
    [[ -n "$host" ]] && kitty @ set-tab-title "ssh:$host" &> /dev/null
    command ssh "$@"
    local status=$?
    [[ -n "$host" ]] && kitty @ set-tab-title "" &> /dev/null
    return $status
}

# }}}
