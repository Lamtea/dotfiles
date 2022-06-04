#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** java-debug updating... *****'

if [[ ! -d $HOME/dev/vscode ]]; then
	mkdir -p ~/dev/vscode ||
		(printf "${ESC}[1;31m%s${ESC}[m\n" '***** ~/dev/vscode could NOT be created. *****' &&
			exit 1)
fi

if [[ ! -d $HOME/dev/vscode/java-debug ]]; then
	(cd ~/dev/vscode &&
		git clone https://github.com/microsoft/java-debug.git) ||
		(printf "${ESC}[1;31m%s${ESC}[m\n" '***** git repository could NOT be cloned. *****' &&
			exit 2)
fi

(cd ~/dev/vscode/java-debug &&
	git pull &&
	./mvnw clean install &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** java-debug updated. *****.' &&
	exit 0) ||
	(printf "${ESC}[1;31m%s${ESC}[m\n" '***** java-debug update failed. *****' &&
		exit 3)
