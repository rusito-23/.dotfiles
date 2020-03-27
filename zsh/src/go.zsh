
# GO VERSION MANAGER
(( ${+aliases[foo]} )) && unalias g

export GOPATH="$HOME/go";
export GOROOT="$HOME/.go";
export PATH="$GOPATH/bin:$PATH";

