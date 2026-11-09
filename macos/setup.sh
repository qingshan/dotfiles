#!/usr/bin/env bash
set -euo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
bash "$script_dir/bootstrap.sh"
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Keep the machine awake for the lifetime of this setup process.
caffeinate -s -w "$$" &
caffeinate_pid=$!
trap 'kill "$caffeinate_pid" 2>/dev/null || true' EXIT

if [[ $(uname -m) == arm64 ]] && ! arch -arch x86_64 uname -m >/dev/null 2>&1; then
  softwareupdate --install-rosetta --agree-to-license
fi

# Installing dotfiles does not implicitly upgrade existing Homebrew packages.
HOMEBREW_BUNDLE_NO_UPGRADE=1 brew bundle --file "$script_dir/Brewfile"
bash "$script_dir/defaults.sh"
