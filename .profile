export PATH="$HOME/.local/bin:$HOME/.bin:$HOME/.dotfiles/bin:$PATH"

# Go
if [ -d "/usr/local/go/bin" ]; then
    export PATH="$PATH:/usr/local/go/bin"
fi
if [ -d "$HOME/.go" ]; then
    export GOPATH="$HOME/.go"
    export PATH="$GOPATH/bin:$PATH"
fi

# Rust
if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

export LANG="en_US.UTF-8"

export EDITOR="vim"
