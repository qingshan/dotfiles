GOPATH=$HOME/go
PATH=$GOPATH/bin:$HOME/.local/bin:$HOME/.bin:/usr/local/go/bin:$PATH

export CGO_CFLAGS="-Wno-return-local-addr"

export GOPATH
export PATH
. "$HOME/.cargo/env"
