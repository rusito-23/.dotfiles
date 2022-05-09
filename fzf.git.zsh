# My `git` + `fzf` additions
# Taken and modified from:
# https://junegunn.kr/2016/07/fzf-git
# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236

# {{{ Helper to check if we're on a git repo

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

# }}}

# {{{ Search local branches using `^G-^O`

fzf_go() {
  is_in_git_repo || return
  git branch --color=always | grep -v '/HEAD\s' | sort |
  fzf --ansi --multi --tac --preview-window right:50% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

# }}}

# {{{ Search remote branches using `^G-^R`

fzf_gr() {
  is_in_git_repo || return
  git branch -r --color=always | grep -v '/HEAD\s' | sort |
  fzf --ansi --multi --tac --preview-window right:50% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

# }}}

# {{{ Search tags using `^G-^T`

fzf_gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf --multi --preview-window right:50% \
    --preview 'git show --color=always {} | head -'$LINES
}

# }}}

# {{{ Search commit hashes using `^G-^H`

fzf_gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

# }}}

# {{{ Set up key bindings

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(fzf_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}

bind-git-helper o r t h
unset -f bind-git-helper

# }}}
