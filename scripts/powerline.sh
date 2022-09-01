#!/bin/sh

POWERLINE_ROOT=$(pip3 show powerline-status | grep Location | sed 's/Location: //')

cat <<EOF > ~/.zshrc.local
# Powerline status
export POWERLINE_THEME_OVERRIDES="default.segment_data.user.display=false;default.segment_data.cwd.args.dir_limit_depth=2"
source $POWERLINE_ROOT/powerline/bindings/zsh/powerline.zsh
EOF

cat <<EOF > ~/.tmux.conf.local
# Powerline status
source $POWERLINE_ROOT/powerline/bindings/tmux/powerline.conf
EOF
