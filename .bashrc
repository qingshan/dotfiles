# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# profile
if [ -f $HOME/.profile ]; then
    . $HOME/.profile
fi

# local bashrc
if [ -f $HOME/.bashrc.local ]; then
    . $HOME/.bashrc.local
fi
