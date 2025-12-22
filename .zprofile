# common profile
source $HOME/.profile

# fish as interactive shell
if [[ $- == *i* ]]; then
    exec fish
fi
