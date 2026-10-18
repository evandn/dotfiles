#!/bin/bash

set -euo pipefail

export PATH=/opt/homebrew/bin:$PATH

if ! command -v brew &>/dev/null; then
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew upgrade && brew bundle --file=- <<EOF
brew "stow"
cask "google-chrome"
cask "orbstack"
cask "tailscale-app"
EOF

defaults write com.apple.finder AppleShowAllFiles -bool true

brew cleanup --prune=all

stow -Rv --no-folding --ignore='\.DS_Store' common darwin
