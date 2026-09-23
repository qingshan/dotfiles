# set PATH for user's local bin
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# set PATH for mise (manages rust, node, python, go)
if [ -d "$HOME/.local/share/mise/shims" ]; then
    export PATH="$HOME/.local/share/mise/shims:$PATH"
fi

# set PATH for user's dotfiles bin
if [ -d "$HOME/.dotfiles/bin" ]; then
    export PATH="$HOME/.dotfiles/bin:$PATH"
fi

# set PATH for user's private bin
if [ -d "$HOME/.bin" ]; then
    export PATH="$HOME/.bin:$PATH"
fi

export LANG="en_US.UTF-8"

export EDITOR="vim"
export VISUAL="vim"
