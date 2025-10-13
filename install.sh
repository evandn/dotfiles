#!/bin/bash

# Enable strict error handling
set -Eeuo pipefail

# Get OS name
OS="$(uname | tr '[:upper:]' '[:lower:]')"

# Install essential packages for Linux
[[ "$OS" == 'linux' ]] && sudo apt update && sudo apt install -y build-essential git

# Clone dotfiles repo if missing
test -d "$HOME/dotfiles" || git clone git@github.com:evandn/dotfiles.git "$_" && cd "$_"

# Run OS-specific installation
bash "scripts/$OS.sh"
