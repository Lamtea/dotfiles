#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** vscode-firefox-debug updating... *****'

if ! command -v npm 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** npm NOT installed. *****'
	exit 1
fi

if [[ ! -d $HOME/dev/vscode ]]; then
	mkdir -p ~/dev/vscode ||
		printf "${ESC}[1;31m%s${ESC}[m\n" '***** ~/dev/vscode could NOT be created. *****' &&
		exit 2
fi

if [[ ! -d $HOME/dev/vscode/vscode-firefox-debug ]]; then
	cd ~/dev/vscode &&
		git https://github.com/firefox-devtools/vscode-firefox-debug.git ||
		printf "${ESC}[1;31m%s${ESC}[m\n" '***** git repository could NOT be cloned. *****' &&
		exit 3
fi

cd ~/dev/vscode/vscode-firefox-debug &&
	npm install &&
	npm run build &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** vscode-firefox-debug updated. *****.' &&
	exit 0 ||
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** vscode-firefox-debug update failed. *****' &&
	exit 4
