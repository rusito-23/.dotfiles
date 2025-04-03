# My back-end tools

# {{{ Kubernetes+`fzf`

# Search pods using ^k^o
fzf-kpods() {
    kubectl get pods | tail -n +2 | awk '{ print $1 }' | fzf
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

fzf-kpods-widget() {
    local result=$(fzf-kpods | join-lines)
    zle reset-prompt
    LBUFFER+=$result
}

zle -N fzf-kpods-widget
bindkey '^K^O' fzf-kpods-widget

# }}}

# TODO:
# docker+fzf
