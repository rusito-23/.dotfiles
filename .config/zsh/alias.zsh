# Alias

# General purpose
alias src='source ~/.zshrc'                             # Quick reload
alias sudoer='sudo -s /bin/zsh'                         # Become sudo with zsh
alias imcat='shellpic --shell24'                        # Use shellpic to display image previews
alias ql='qlmanage -p > /dev/null 2> /dev/null'         # Open file with macOS Quick-Look
alias xargs='xargs -I%'                                 # Use `%` as default `xargs` placeholder
alias t='tmux'                                          # With great power comes great responsibility
alias now='date +%d.%m.%y-%H:%M:%S'                     # The current date and time, use wisely!
alias mk='make'                                         # Just me being really lazy so what

# Navigation
alias ls='ls -GFh'              # Default ls config
alias ll='ls -lh'               # Long list command
alias la='ls -a'                # Hidden files
alias cd..='cd ../'             # Fix common typo
alias ..='cd ../'               # Navigate with dots
alias ...='cd ../../'           # Navigate with dots

# Edition
alias mdedit='open -a MacDown'      # Edit markdown
alias vi='nvim'                     # Always use `vi`
alias vim='nvim'                    # Always use `vi`
alias cat='bat'                     # Use `bat` as default
alias diff='nvim -d '               # Use nvim to diff stuff

# Git
unalias gcb                                   # I don't care what this does, I want to use it myself
unalias gpu                                   # This git plugin alias pushes to the upstream (it's f* dangerous)
alias gcb='git_current_branch'                # Display current branch
alias gdt='git difftool -y'                   # Diff tool
alias gmt='git mergetool'                     # Merge tool
alias gs='git status --ignore-submodules -s'  # Quick git status

# Bare Dotfiles
alias dot='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias dss='dot status --short'
alias da='dot add'
alias dcmsg='dot commit -m'
alias ddp='dot push origin main'

# Python
alias py='ipython'                      # Start ipython session
alias jn='jupyter notebook'             # Start jupyter notebook server
alias jl='jupyter lab'                  # Start jupyter lab server

# Network Utils
alias ipv4="curl 'https://api.ipify.org'"
alias ipv6="curl 'https://api6.ipify.org'"
