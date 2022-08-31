GOPATH=$HOME/go
PATH=$HOME/Library/Python/3.9/bin:$GOPATH/bin:$HOME/.local/bin:$HOME/.bin:$PATH

export CGO_CFLAGS="-Wno-return-local-addr"

export GOPATH
export PATH
. "$HOME/.cargo/env"
