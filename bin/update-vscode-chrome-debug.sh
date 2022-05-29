#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** vscode-chrome-debug updating... *****'

if ! command -v npm 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** npm NOT installed. *****'
	exit 1
fi

if [[ ! -d $HOME/dev/vscode ]]; then
	mkdir -p ~/dev/vscode ||
		printf "${ESC}[1;31m%s${ESC}[m\n" '***** ~/dev/vscode could NOT be created. *****' &&
		exit 2
fi

if [[ ! -d $HOME/dev/vscode/vscode-chrome-debug ]]; then
	cd ~/dev/vscode &&
		git https://github.com/microsoft/vscode-chrome-debug.git ||
		printf "${ESC}[1;31m%s${ESC}[m\n" '***** git repository could NOT be cloned. *****' &&
		exit 3
fi

cd ~/dev/vscode/vscode-chrome-debug &&
	npm install &&
	npm run build &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** vscode-chrome-debug updated. *****.' &&
	exit 0 ||
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** vscode-chrome-debug update failed. *****' &&
	exit 4
