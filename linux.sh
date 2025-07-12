#!/bin/bash

# Enable strict error handling
set -Eeuo pipefail

# Check if running on Linux
[[ "$(uname)" == 'Linux' ]]

# Update and upgrade system packages
sudo apt update && sudo apt upgrade -y

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
brew "go"
brew "rustup"
brew "stow"
brew "oven-sh/bun/bun"
EOF

# Remove all cache files
brew cleanup --prune=all

# Symlink config files
stow -Rvt "$HOME" common linux

# Add Homebrew to shell configuration
grep -q 'brew shellenv' "$HOME/.bashrc" || {
    echo -e '\neval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>"$_"
}

# Set default Rust toolchain
rustup show active-toolchain &>/dev/null || rustup default stable

# Add Rust to PATH
grep -q 'rustup' "$HOME/.profile" || {
    echo -e "\nPATH=\"$(brew --prefix rustup)/bin:\$PATH\"" >>"$_"
}

# Check if Docker is installed
command -v docker &>/dev/null || {
    # Install Docker
    curl -fsSL https://get.docker.com | sh

    # Add current user to the docker group
    sudo usermod -aG docker "$USER"
}
