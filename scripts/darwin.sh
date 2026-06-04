#!/bin/bash

# Enable strict error handling
set -Eeuo pipefail

# Add Homebrew to PATH (Apple Silicon)
export PATH="/opt/homebrew/bin:$PATH"

# Install Homebrew if missing
command -v brew &>/dev/null || bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Update Homebrew and upgrade packages
brew update && brew upgrade

# Install packages
brew bundle --file=/dev/stdin <<EOF
brew "openssh"
brew "stow"
brew "evandn/tap/ssh-askpass"
cask "cleanshot"
cask "free-download-manager"
cask "google-chrome"
cask "mos"
cask "orbstack"
cask "tableplus"
cask "tailscale-app"
cask "warp"
cask "zed"
EOF

# Remove all cache files
brew cleanup --prune=all

# Symlink config files
stow -Rvt "$HOME" --ignore='\.DS_Store' common darwin

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
