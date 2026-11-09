#!/usr/bin/env bash
set -euo pipefail

if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install
  echo "Finish installing Xcode Command Line Tools, then run make again." >&2
  exit 1
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if ! command -v brew >/dev/null 2>&1; then
  installer=$(mktemp)
  trap 'rm -f "$installer"' EXIT
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o "$installer"
  /bin/bash "$installer"
  case $(uname -m) in
    arm64) eval "$(/opt/homebrew/bin/brew shellenv)" ;;
    x86_64) eval "$(/usr/local/bin/brew shellenv)" ;;
  esac
fi

# Base CLI dependencies only; GUI applications belong to make desktop.
HOMEBREW_NO_INSTALL_UPGRADE=1 brew install bash fish curl git mise vim
