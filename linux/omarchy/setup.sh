#!/usr/bin/env bash
set -euo pipefail

# Base CLI packages this dotfiles repo needs that aren't part of Omarchy's
# own default install (Omarchy already ships things like ripgrep, fd, bat,
# fzf, zoxide, starship, tmux, git, herdr, mise/node). All of these are in
# the official Arch repos, no AUR helper required.
sudo pacman -S --noconfirm --needed \
  fish \
  zsh \
  vim \
  lsd \
  git-delta \
  just \
  wget \
  rustup \
  uv \
  nnn \
  autossh \
  zk
