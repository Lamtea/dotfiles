#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** asdf ruby and bundle updating... *****'

if ! command -v asdf 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf NOT installed. *****'
	exit 1
fi

PLUGIN="$(asdf plugin-list | grep 'ruby' 2>/dev/null)"
if [[ -z "$PLUGIN" ]]; then
	if asdf plugin-add ruby; then
		printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf ruby plugin installed. *****'
	else
		printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf ruby plugin install failed. *****'
		exit 2
	fi
fi

(asdf install ruby latest &&
	asdf global ruby "$(asdf list ruby | grep -o '[0-9.]\+' | tail -n 1 | xargs)" &&
	cd "$HOME" &&
	bundle install &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf ruby and bundle updated. *****' &&
	exit 0) ||
	(printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf ruby and bundle update failed. *****' &&
		exit 3)
