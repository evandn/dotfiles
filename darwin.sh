#!/bin/bash

# Enable strict error handling
set -Eeuo pipefail

# Check if running on macOS
[[ "$(uname)" == 'Darwin' ]]

# Add Homebrew to PATH (Apple Silicon)
export PATH="/opt/homebrew/bin:$PATH"

# Check if Homebrew is installed
command -v brew &>/dev/null || {
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Disable Homebrew analytics
    brew analytics off
}

# Update Homebrew and upgrade installed packages
brew update && brew upgrade

# Install packages
brew bundle --file=/dev/stdin <<EOF
brew "stow"
brew "evandn/tap/ssh-askpass"

cask "cleanshot"
cask "font-jetbrains-mono"
cask "free-download-manager"
cask "google-chrome"
cask "logi-options+"
cask "obsidian"
cask "orbstack"
cask "proxyman"
cask "raycast"
cask "screen-studio"
cask "ssh-config-editor"
cask "tableplus"
cask "visual-studio-code"
cask "vlc"
cask "wezterm"

mas "OneDrive", id: 823766827
mas "PDFgear", id: 6469021132
mas "Tailscale", id: 1475387142
mas "Telegram", id: 747648890
mas "Whisper Transcription", id: 1668083311
mas "Xcode", id: 497799835
mas "Yubico Authenticator", id: 1497506650
EOF

# Remove all cache files
brew cleanup --prune=all

# Symlink config files
stow -Rvt "$HOME" --ignore='\.DS_Store' common darwin

# Set system preferences
defaults write com.apple.finder AppleShowAllFiles -bool true
