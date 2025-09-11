#!/usr/bin/sh

sudo dnf update -y
sudo dnf install -y epel-release
sudo dnf install -y make \
  curl \
  wget \
  fish \
  fzf \
  git \
  vim \
  ripgrep \
  zoxide \
  tmux

sudo dnf install 'dnf-command(config-manager)'

# docker
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce -y
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo usermod -aG docker $USER

# github
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install -y gh

# starship
dnf copr enable -y atim/starship
dnf install -y starship

# TODO install latest version of fish/starship/just
# https://github.com/fish-shell/fish-shell/releases
# https://github.com/starship/starship/releases
# https://github.com/casey/just/releases
