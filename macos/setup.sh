#!/usr/bin/env bash
set -euxo pipefail # -e=-o errexit, -u=-o nounset

# Ask for the administrator password upfront
sudo -n true 2>/dev/null || sudo -v
# Keep-alive: update existing `sudo` time stamp until `init.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Prevent sleeping during script execution, as long as the machine is on AC power
caffeinate -s -w $$ &

# Install xcode commandline tools
if [[ ! $(xcode-select -p 1>/dev/null; echo $?) ]]; then
  echo "Install xcode commandline tools"
  xcode-select --install
fi

# Install Rosetta 2
if ! (arch -arch x86_64 uname -m > /dev/null) ; then
  echo "Install Rosetta 2"
  softwareupdate --install-rosetta --agree-to-license
fi

# Install homebrew
if [[ $(command -v brew) == "" ]]; then
  echo "Install homebrew"
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | /bin/bash
fi

case `uname -m` in
arm64)
    eval "$(/opt/homebrew/bin/brew shellenv)" ;;
x86_64)
    eval "$(/usr/local/bin/brew shellenv)" ;;
esac

# Install all dependencies from the Brewfile
echo "Install brew bundle"
brew bundle -v --no-lock --file ~/.dotfiles/macos/Brewfile || true

# Apply macOS system settings
. ~/.dotfiles/macos/defaults.sh"
