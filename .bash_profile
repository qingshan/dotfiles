# common profile
source $HOME/.dotfiles/.profile

# local bashrc
if [ -f $HOME/.bashrc ]; then
  . $HOME/.bashrc
fi
