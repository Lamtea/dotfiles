#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** lombok updating... *****'

if [[ -d $HOME/dev/lsp/lombok ]]; then
	rm -rf ~/dev/lsp/lombok ||
		(printf "${ESC}[1;31m%s${ESC}[m\n" '***** ~/dev/lsp/lombok could NOT be removed. *****' &&
			exit 1)
fi

(mkdir -p ~/dev/lsp/lombok &&
	cd ~/dev/lsp/lombok &&
	wget https://projectlombok.org/downloads/lombok.jar -O lombok.jar &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** lombok updated. *****.' &&
	exit 0) ||
	(printf "${ESC}[1;31m%s${ESC}[m\n" '***** lombok update failed. *****' &&
		exit 3)
