#!/bin/bash

# Enable strict error handling
set -Eeuo pipefail

# Add Homebrew to PATH
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

# Install Homebrew if missing
command -v brew &>/dev/null || NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Update Homebrew and upgrade packages
brew update && brew upgrade

# Install packages
brew bundle --file=/dev/stdin <<EOF
brew "go"
brew "node"
brew "ouch"
brew "rustup"
brew "stow"
brew "uv"
brew "oven-sh/bun/bun"
EOF

# Remove all cache files
brew cleanup --prune=all

# Symlink config files
stow -Rvt "$HOME" common linux

# Add Homebrew to shell configuration
grep -q 'brew' "$HOME/.bashrc" || echo -e '\neval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>"$_"

# Set default Rust toolchain
rustup show active-toolchain &>/dev/null || rustup default stable

# Add Rust toolchain to PATH
grep -q 'rustup' "$HOME/.profile" || echo -e "\nPATH=\"$(brew --prefix rustup)/bin:\$PATH\"" >>"$_"

# Check if Docker is missing
command -v docker &>/dev/null || {
    # Install Docker
    curl -fsSL https://get.docker.com | sudo sh

    # Add current user to the docker group
    sudo usermod -aG docker "$USER"
}

# Remove unused packages and cache
sudo apt autoremove --purge -y && sudo apt clean
