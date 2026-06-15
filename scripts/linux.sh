#!/bin/bash

set -euo pipefail

sudo apt update && sudo apt full-upgrade -y

sudo apt install -y build-essential git

export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH

if ! command -v brew &>/dev/null; then
	NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update && brew upgrade

brew bundle --file=/dev/stdin <<EOF
brew "go"
brew "node"
brew "rustup"
brew "stow"
brew "uv"
EOF

if ! grep -q brew $HOME/.bashrc; then
	echo -e '\neval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>$_
fi

if ! grep -q rustup $HOME/.profile; then
	echo -e "\nPATH=\"$(brew --prefix rustup)/bin:\$PATH\"" >>$_
fi

if ! command -v docker &>/dev/null; then
	curl -fsSL https://get.docker.com | sudo sh

	sudo usermod -aG docker $USER
fi

brew cleanup --prune=all

sudo apt autoremove --purge -y && sudo apt clean

stow -Rv --no-folding common
