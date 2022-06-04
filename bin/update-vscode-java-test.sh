#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** vscode-java-test updating... *****'

if ! command -v npm 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** npm NOT installed. *****'
	exit 1
fi

if [[ ! -d $HOME/dev/vscode ]]; then
	mkdir -p ~/dev/vscode ||
		(printf "${ESC}[1;31m%s${ESC}[m\n" '***** ~/dev/vscode could NOT be created. *****' &&
			exit 2)
fi

if [[ ! -d $HOME/dev/vscode/vscode-java-test ]]; then
	(cd ~/dev/vscode &&
		git clone https://github.com/microsoft/vscode-java-test.git) ||
		(printf "${ESC}[1;31m%s${ESC}[m\n" '***** git repository could NOT be cloned. *****' &&
			exit 3)
fi

(cd ~/dev/vscode/vscode-java-test &&
	git pull &&
	npm install &&
	npm run build-plugin &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** vscode-java-test updated. *****.' &&
	exit 0) ||
	(printf "${ESC}[1;31m%s${ESC}[m\n" '***** vscode-java-test update failed. *****' &&
		exit 4)
