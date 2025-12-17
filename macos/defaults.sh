#!/usr/bin/env bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Appearance
defaults write NSGlobalDomain AppleInterfaceStyle -string Dark

# Languages
defaults write NSGlobalDomain AppleLanguages -array "en-US" "zh-Hans-US"

# Dock: auto-hide
defaults write com.apple.dock autohide -bool true
# Dock: show recents
defaults write com.apple.dock show-recents -bool false
# Dock: orientation
defaults write com.apple.dock orientation -string left
# Dock: corners
defaults write com.apple.dock wvous-bl-corner -int 14
defaults write com.apple.dock wvous-br-corner -int 13
defaults write com.apple.dock wvous-tl-corner -int 11
defaults write com.apple.dock wvous-tr-corner -int 12

# Disable press-and-hold for keys in favor of key repeat.
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable .DS_Store on network disks
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Finder
defaults write com.apple.finder QuitMenuItem -bool true
defaults write com.apple.finder NewWindowTarget -string PfHm
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false

# Crash reporter
defaults write com.apple.CrashReporter DialogType -string none

# Screen capture
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture location ~/Downloads

echo "Done. Note that these changes require a logout/restart to take effect."
