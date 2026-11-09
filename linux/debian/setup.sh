#!/usr/bin/env bash

set -euo pipefail

if [ -f /etc/os-release ]; then
  . /etc/os-release
fi

if [ "${ID:-}" = "ubuntu" ]; then
  sudo apt-get update
  sudo apt-get install -y software-properties-common
  sudo apt-add-repository -y ppa:fish-shell/release-4
fi

sudo apt-get update
sudo apt-get install -y \
  ca-certificates \
  curl \
  wget \
  make \
  git \
  fish \
  unzip \
  rsync \
  autossh \
  vim

# mise (manages node, python, go, and various CLI tools:
# ripgrep, fd, bat, zoxide, tmux, gh, jq, rust, starship, fzf, etc.)
if ! command -v mise >/dev/null 2>&1; then
  curl -fsSL https://mise.run | sh
fi
