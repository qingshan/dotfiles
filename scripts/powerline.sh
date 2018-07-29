#!/bin/sh
echo "Installing Powerline status..."
pip3 install powerline-status
POWERLINE_ROOT=$(pip3 show powerline-status | grep Location | sed 's/Location: //')

cat <<EOF > ~/.zshrc.local
# Powerline status
powerline-daemon -q
source $POWERLINE_ROOT/powerline/bindings/zsh/powerline.zsh
EOF

cat <<EOF > ~/.tmux.conf.local
# Powerline status
run-shell "powerline-daemon -q"
source $POWERLINE_ROOT/powerline/bindings/tmux/powerline.conf
EOF
