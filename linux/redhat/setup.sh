#!/usr/bin/env bash
set -euo pipefail

echo "Install tools"
sudo dnf install -y epel-release
sudo dnf install -y make \
  ca-certificates \
  unzip \
  rsync \
  xz \
  curl \
  wget \
  git \
  autossh \
  vim

sudo dnf install -y 'dnf-command(config-manager)'

# fish
echo "Install fish"
if ! command -v fish >/dev/null 2>&1; then
  FISH_VERSION=$(curl -fsSL "https://api.github.com/repos/fish-shell/fish-shell/releases/latest" | grep -Po '"tag_name": "\K[0-9.]+')
  test -n "$FISH_VERSION"
  case $(uname -m) in
    x86_64) fish_arch=x86_64 ;;
    aarch64) fish_arch=aarch64 ;;
    *) echo "Unsupported fish architecture: $(uname -m)" >&2; exit 1 ;;
  esac
  curl -fsSL "https://github.com/fish-shell/fish-shell/releases/download/$FISH_VERSION/fish-$FISH_VERSION-linux-$fish_arch.tar.xz" | sudo tar -xJ -C /usr/local/bin
fi

# mise (manages node, python, go, and various CLI tools:
# fzf, ripgrep, fd, zoxide, tmux, gh, starship, rust, just, uv, etc.)
echo "Install mise"
if ! command -v mise >/dev/null 2>&1; then
  curl -fsSL https://mise.run | sh
fi
