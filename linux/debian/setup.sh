#!/bin/sh

sudo add-apt-repository ppa:fish-shell/release-4
sudo apt update
sudo apt install -y \
  curl \
  wget \
  make \
  git \
  fish \
  unzip \
  ripgrep \
  fd-find \
  bat \
  direnv \
  zoxide \
  htop \
  rsync \
  tmux \
  vim \
  gh \
  jq \
  rustup

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt-get install -y nodejs

if [ -f /etc/os-release ]; then
  source /etc/os-release
  if [[ "$ID" == "debian" ]]; then
    sudo apt install -y starship fzf
  elif [[ "$ID" == "ubuntu" ]]; then
    curl -sS https://starship.rs/install.sh | sudo sh -s -- --yes
    FZF_VERSION=$(curl -s "https://api.github.com/repos/junegunn/fzf/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
    curl -sL "https://github.com/junegunn/fzf/releases/latest/download/fzf-$FZF_VERSION-linux_amd64.tar.gz" | sudo tar -xz -C /usr/local/bin
  else
    echo "This system is neither Debian nor Ubuntu (ID: $ID)."
  fi
fi
