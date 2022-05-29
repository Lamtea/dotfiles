#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** asdf ktlint updateting... *****'

if ! command -v asdf 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf NOT installed.*****'
	exit 1
fi

PLUGIN="$(asdf plugin-list | grep 'ktlint' 2>/dev/null)"
if [[ -z "$PLUGIN" ]]; then
	if asdf plugin-add ktlint; then
		printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf ktlint plugin installed. *****'
	else
		printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf ktlint plugin install failed. *****'
		exit 2
	fi
fi

asdf install ktlint latest &&
	asdf global ktlint "$(asdf list ktlint | grep '[0-9]\+' | tail -n 1 | xargs)" &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf ktlint updated. *****.' &&
	exit 0 ||
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf ktlint update failed. *****' &&
	exit 3
