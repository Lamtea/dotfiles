#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** asdf dart updating... *****'

if ! command -v asdf 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf NOT installed. *****'
	exit 1
fi

PLUGIN="$(asdf plugin-list | grep 'dart' 2>/dev/null)"
if [[ -z "$PLUGIN" ]]; then
	if asdf plugin-add dart; then
		asdf global dart system
		printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf dart plugin installed (and set: asdf global dart system). *****'
	else
		printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf dart plugin install failed. *****'
		exit 2
	fi
fi

(asdf install dart latest &&
	asdf global dart "$(asdf list dart | grep -o '[0-9.]\+' | tail -n 1 | xargs)" &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf dart updated. *****' &&
	exit 0) ||
	(printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf dart update failed. *****' &&
		exit 3)
