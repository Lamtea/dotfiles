#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** asdf nodejs updating... *****'

if ! command -v asdf 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf NOT installed. *****'
	exit 1
fi

PLUGIN="$(asdf plugin-list | grep 'nodejs' 2>/dev/null)"
if [[ -z "$PLUGIN" ]]; then
	if asdf plugin-add nodejs; then
		asdf global nodejs system
		printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf nodejs plugin installed (and set: asdf global nodejs system). *****'
	else
		printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf nodejs plugin install failed. *****'
		exit 2
	fi
fi

(asdf install nodejs latest &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf nodejs updated (If you want to use latest: asdf local nodejs [version]). *****' &&
	exit 0) ||
	(printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf nodejs update failed. *****' &&
		exit 3)
