#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** asdf golang updateting... *****'

if ! command -v asdf 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf NOT installed.*****'
	exit 1
fi

PLUGIN="$(asdf plugin-list | grep 'golang' 2>/dev/null)"
if [[ -z "$PLUGIN" ]]; then
	if asdf plugin-add golang; then
		asdf global golang system
		printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf golang plugin installed (and set: asdf global golang system). *****'
	else
		printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf golang plugin install failed. *****'
		exit 2
	fi
fi

asdf install golang latest &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf golang updated (If you want to use latest: asdf local golang [version]). *****.' &&
	exit 0 ||
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf golang update failed. *****' &&
	exit 3
