#!/bin/bash

set -euo pipefail

if ! test -d $HOME/dotfiles; then
	mkdir $_ && tar xz --strip-components=1 -f <(curl -fsSL https://github.com/evandn/dotfiles/tarball/HEAD) -C $_
fi

cd $_ && bash scripts/$(uname | tr '[:upper:]' '[:lower:]').sh
