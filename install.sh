#!/bin/bash

# Enable strict error handling
set -Eeuxo pipefail

# Get OS name
OS="$(uname | tr '[:upper:]' '[:lower:]')"

# Install essential packages for Linux
[[ "$OS" == 'linux' ]] && sudo apt update && sudo apt full-upgrade -y && sudo apt install -y build-essential git

# Clone dotfiles repo if missing
test -d "$HOME/dotfiles" || GIT_SSH_COMMAND='ssh -o StrictHostKeyChecking=no' git clone git@github.com:evandn/dotfiles.git "$_" && cd "$_"

# Run OS-specific installation
bash "scripts/$OS.sh"
