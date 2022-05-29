#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** asdf neovim updateting... *****'

if ! command -v asdf 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf NOT installed. *****'
	exit 1
fi

PLUGIN="$(asdf plugin-list | grep 'neovim' 2>/dev/null)"
if [[ -z "$PLUGIN" ]]; then
	if asdf plugin-add neovim; then
		printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf neovim plugin installed. *****'
	else
		printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf neovim plugin install failed. *****'
		exit 2
	fi
fi

asdf uninstall neovim nightly &&
	asdf install neovim nightly 2>/dev/null &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf neovim updated. *****.' &&
	exit 0 ||
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf neovim update failed. *****' &&
	exit 3
