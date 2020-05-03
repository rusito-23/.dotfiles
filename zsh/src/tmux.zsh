
alias tmuxx='tmux source-file ~/.tmux.conf'

# set unset tmux for nested sessions
alias unsetmux='OLD_TMUX=$TMUX;TMUX=""'
alias resetmux='TMUX=$OLD_TMUX'

# quick edit file with vim in new pane
qckvi() {
    tmux split-window -h -c "#{pane_current_path}" "vi $@"
}
