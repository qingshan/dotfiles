# set PATH for mise (manages node, python, go)
if [ -d "$HOME/.local/share/mise/shims" ]; then
    export PATH="$HOME/.local/share/mise/shims:$PATH"
fi

# set PATH for Rust
if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# set PATH for AI
if [ -d "$HOME/.grok/bin" ]; then
    export PATH="$HOME/.grok/bin:$PATH"
fi

# set PATH for user's private bin
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.dotfiles/bin" ]; then
    export PATH="$HOME/.dotfiles/bin:$PATH"
fi
if [ -d "$HOME/.bin" ]; then
    export PATH="$HOME/.bin:$PATH"
fi

export LANG="en_US.UTF-8"

export EDITOR="vim"
export VISUAL="vim"
