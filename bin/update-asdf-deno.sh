#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** asdf deno updating... *****'

if ! command -v asdf 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf NOT installed. *****'
	exit 1
fi

PLUGIN="$(asdf plugin-list | grep 'deno' 2>/dev/null)"
if [[ -z "$PLUGIN" ]]; then
	if asdf plugin-add deno; then
		asdf global deno system
		printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf deno plugin installed (and set: asdf global deno system). *****'
	else
		printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf deno plugin install failed. *****'
		exit 2
	fi
fi

asdf install deno latest &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf deno updated (If you want to use latest: asdf local deno [version]). *****.' &&
	exit 0 ||
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf deno update failed. *****' &&
	exit 3
