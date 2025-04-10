#!/bin/bash

# Enable strict error handling
set -Eeuo pipefail

# Get OS
OS="$(uname)"

# Install dependencies for Linux
[[ "$OS" == 'Linux' ]] && sudo apt update && sudo apt install -y build-essential git

# Clone and run OS-specific setup
git clone https://github.com/evandn/dotfiles.git "$HOME/dotfiles" && cd "$_" && ./"${OS,,}.sh"
