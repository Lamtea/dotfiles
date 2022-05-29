#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** asdf hadolint updating... *****'

if ! command -v asdf 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf NOT installed. *****'
	exit 1
fi

PLUGIN="$(asdf plugin-list | grep 'hadolint' 2>/dev/null)"
if [[ -z "$PLUGIN" ]]; then
	if asdf plugin-add hadolint; then
		printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf hadolint plugin installed. *****'
	else
		printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf hadolint plugin install failed. *****'
		exit 2
	fi
fi

asdf install hadolint latest &&
	asdf global hadolint "$(asdf list hadolint | grep '[0-9]\+' | tail -n 1 | xargs)" &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf hadolint updated. *****.' &&
	exit 0 ||
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf hadolint update failed. *****' &&
	exit 3
