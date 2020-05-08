
# virtualenvwrapper aliases

alias vew='virtualenvwrapper'
alias mkve='mkvirtualenv'
alias rmve='rmvirtualenv'
alias lve='lsvirtualenv'

# ipython

alias py='ipython'

# jupyter aliases

alias jn='jupyter notebook'
alias jl='jupyter lab'

# pyenv init 
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    pyenv virtualenvwrapper
fi
