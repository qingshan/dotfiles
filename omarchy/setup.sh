#!/usr/bin/env bash
set -euo pipefail

# Symlink dotfiles-managed Hyprland overrides. See manual/31-dotfiles.md:
# ~/.config/hypr/*.lua are "your files", loaded on top of Omarchy's own
# defaults in /usr/share/omarchy, so it's safe to manage them here.
mkdir -p "${HOME}/.config/hypr"
ln -snf ../../.dotfiles/omarchy/hypr/input.lua "${HOME}/.config/hypr/input.lua"
ln -snf ../../.dotfiles/omarchy/hypr/bindings.lua "${HOME}/.config/hypr/bindings.lua"
