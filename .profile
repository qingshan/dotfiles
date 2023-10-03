export PATH="$HOME/.local/bin:$HOME/.bin:$PATH"

# Go
if [ -d "/usr/local/go/bin" ]; then
    export PATH="$PATH:/usr/local/go/bin"
fi
if [ -d "$HOME/.go" ]; then
    export GOPATH=$HOME/.go
    export PATH="$GOPATH/bin:$PATH"
fi

# Rust
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
