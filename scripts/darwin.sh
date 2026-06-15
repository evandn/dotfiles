#!/bin/bash

set -euo pipefail

export PATH=/opt/homebrew/bin:$PATH

if ! command -v brew &>/dev/null; then
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update && brew upgrade

brew bundle --file=/dev/stdin <<EOF
brew "stow"
cask "free-download-manager"
cask "google-chrome"
cask "orbstack"
cask "tailscale-app"
cask "zed"
EOF

defaults write com.apple.finder AppleShowAllFiles -bool true

brew cleanup --prune=all

stow -Rv --no-folding --ignore='\.DS_Store' common darwin
