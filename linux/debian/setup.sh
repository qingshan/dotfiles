#!/bin/sh

set -e

if [ -f /etc/os-release ]; then
  . /etc/os-release
fi

if [ "$ID" = "ubuntu" ]; then
  sudo apt-get update
  sudo apt-get install -y software-properties-common
  sudo apt-add-repository -y ppa:fish-shell/release-4
fi

sudo apt update
sudo apt install -y \
  ca-certificates \
  curl \
  wget \
  make \
  git \
  fish \
  unzip \
  ripgrep \
  fd-find \
  bat \
  zoxide \
  htop \
  rsync \
  tmux \
  vim \
  gh \
  jq \
  rustup

# mise (manages node, python, go)
curl -fsSL https://mise.run | sh

if [ "$ID" = "debian" ]; then
  sudo apt install -y starship fzf
elif [ "$ID" = "ubuntu" ]; then
  curl -sS https://starship.rs/install.sh | sudo sh -s -- --yes
  FZF_VERSION=$(curl -s "https://api.github.com/repos/junegunn/fzf/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
  curl -sL "https://github.com/junegunn/fzf/releases/latest/download/fzf-$FZF_VERSION-linux_amd64.tar.gz" | sudo tar -xz -C /usr/local/bin
else
  echo "This system is neither Debian nor Ubuntu (ID: $ID)."
fi
