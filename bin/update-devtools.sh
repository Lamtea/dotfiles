#!/bin/bash

update-mise.sh &&
	update-poetry.sh &&
	update-rustup.sh &&
	update-ghcup.sh &&
	update-ruby-bundle.sh &&
	update-dotnet-tools.sh
