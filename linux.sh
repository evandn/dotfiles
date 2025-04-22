#!/bin/bash

# Enable strict error handling
set -Eeuo pipefail

# Check if running on Linux
[[ "$(uname)" == 'Linux' ]]

# Add Homebrew to PATH
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

# Check if Homebrew is installed
command -v brew &>/dev/null || {
    # Install Homebrew
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Disable Homebrew analytics
    brew analytics off
}

# Update Homebrew and upgrade installed packages
brew update && brew upgrade

# Install packages
brew bundle --file=/dev/stdin <<EOF
brew "fish"
brew "stow"
EOF

# Remove all cache files
brew cleanup --prune=all

# Symlink config files
stow -Rvt "$HOME" common linux

# Add Homebrew to shell configuration
grep -q 'brew shellenv' "$HOME/.bashrc" || {
    echo -e '\neval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>"$_"
}
