# .zshrc

# profile
if [ -f $HOME/.profile ]; then
    source $HOME/.profile
fi

# local zshrc
if [ -f $HOME/.zshrc.local ]; then
    source $HOME/.zshrc.local
fi
