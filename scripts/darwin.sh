#!/bin/bash

# Enable strict error handling
set -Eeuxo pipefail

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
cask "font-jetbrains-mono"
cask "free-download-manager"
cask "google-chrome"
cask "iina"
cask "logi-options+"
cask "obsidian"
cask "orbstack"
cask "proxyman"
cask "raycast"
cask "screen-studio"
cask "ssh-config-editor"
cask "tableplus"
cask "tailscale-app"
cask "visual-studio-code"
cask "wezterm"
EOF

# Remove all cache files
brew cleanup --prune=all

# Symlink config files
stow -Rvt "$HOME" --ignore='\.DS_Store' common darwin

# Set system preferences
defaults write com.apple.finder AppleShowAllFiles -bool true
