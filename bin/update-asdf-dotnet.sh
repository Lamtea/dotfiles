#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** asdf dotnet updating... *****'

if ! command -v asdf 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf NOT installed. *****'
	exit 1
fi

PLUGIN="$(asdf plugin-list | grep 'dotnet' 2>/dev/null)"
if [[ -z "$PLUGIN" ]]; then
	if asdf plugin-add dotnet; then
		printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf dotnet plugin installed. *****'
	else
		printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf dotnet plugin install failed. *****'
		exit 2
	fi
fi

(asdf install dotnet latest &&
	asdf global dotnet "$(asdf list dotnet | grep -o '[0-9.]\+' | tail -n 1 | xargs)" &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf dotnet updated. *****' &&
	exit 0) ||
	(printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf dotnet update failed. *****' &&
		exit 3)
