#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** dotnet-core tools updating... *****'

if ! command -v dotnet 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** dotnet-core NOT installed. *****'
	exit 1
fi

dotnet tool update -g dotnet-aspnet-codegenerator &&
	dotnet tool update -g dotnet-ef &&
	dotnet tool update -g powershell &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** dotnet-core tools updated. *****.' &&
	exit 0 ||
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** dotnet-core tools update failed. *****' &&
	exit 2
