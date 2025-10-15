#!/usr/bin/sh

sudo apt update
sudo apt install -y \
  curl \
  wget \
  make \
  git \
  fish \
  fzf \
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

if [ -f /etc/os-release ]; then
  source /etc/os-release
  if [[ "$ID" == "debian" ]]; then
    sudo apt install -y starship
  elif [[ "$ID" == "ubuntu" ]]; then
    curl -sS https://starship.rs/install.sh | sh
  else
    echo "This system is neither Debian nor Ubuntu (ID: $ID)."
  fi
fi
