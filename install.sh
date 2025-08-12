#!/bin/bash

# Enable strict error handling
set -Eeuo pipefail

# Get OS
OS="$(uname | tr '[:upper:]' '[:lower:]')"

# Install dependencies for Linux
[[ "$OS" == 'linux' ]] && sudo apt update && sudo apt install -y build-essential git

# Clone and run OS-specific setup
git clone git@github.com:evandn/dotfiles.git "$HOME/dotfiles" && cd "$_" && ./"$OS.sh"
