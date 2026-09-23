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
  rsync \
  vim

# mise (manages node, python, go, and various CLI tools:
# ripgrep, fd, bat, zoxide, tmux, gh, jq, rust, starship, fzf, etc.)
curl -fsSL https://mise.run | sh
