#!/bin/bash

update-mise.sh &&
	update-rustup.sh &&
	update-ghcup.sh &&
	update-ruby-bundle.sh &&
	update-php-composer.sh &&
	update-etc.sh
