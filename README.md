# dotfiles

My dotfiles for command line interface on Arch linux.

## Overview

![a](https://user-images.githubusercontent.com/48638671/171588449-9a133364-cb2b-4423-a661-0510a0940431.png)

## How to install

```bash
paru -S <dependent packages>
# Install arch packages and aur packages.
# Options can be ignored.
```

```bash
cd ~
git clone https://github.com/Lamtea/dotfiles.git .dotfiles
```

```bash
cd .dotfiles
vi .gitconfig
  email = <your email address>
vi .config/neomutt/neomuttrc
  set my_name="<your name>"
./install.sh
```

```bash
exec zsh
# Install zsh plugins and some packages from git.
```

```bash
~/bin/update-devtools.sh
# Install asdf tools, dotnet tools, pyenv, poetry, ghcup, rustup,
# vscode extensions, neovim nightly, etc...
```

```bash
vi +PackerSync +qall
# Install neovim plugins.
```

## Depend on

- asdf(from git clone)
  - deno(asdf)
  - dotnet(asdf)
  - golang(asdf)
    - delve(go get)
  - golangci-lint(asdf, go linter)
  - hadolint(asdf, dockerfile linter)
  - ktlint(asdf, kotlin linter/formatter)
  - neovim(asdf)
  - nodejs(asdf)
    - editorconfig-checker(npm)
    - eslint(npm)
    - jsonlint(npm)
    - markdownlint-cli(npm)
    - neovim(npm)
    - prettier(npm)
    - stylelint(npm)
    - tidy(npm)
    - typescript(npm)
    - yaml-lint(npm)
    - etc...(for development)
  - ruby(asdf)
    - bundler(gem)
- aspnet-runtime
- aspnet-targeting-pack
- base-devel
- bashdb(aur)
- bemenu
- clang
- cmake
- codespell(spell linter/formatter)
- composer
- colordiff
- cppcheck(c/cpp linter)
- dart
- dart-sass
- delve(go debugger)
- deno
- dotnet-host
- dotnet-runtime
- dotnet-sdk
- dotnet-targeting-pack
- editorconfig-checker(editorconfig linter)
- eslint(for javascript/typescript/react/vue linter)
- fd
- flake8(python linter)
- fzf
- gawk
- ghcup-hs-bin(aur)
  - ghc(ghcup)
  - stack(ghcup)
    - haskell-dap(stack, haskell debugger)
    - ghci-dap(stack, haskell debugger)
    - haskell-debug-adapter(stack, haskell debugger)
    - fourmolu(stack, haskell formatter)
- git
- github-cli
- gnome-keyring
- go
- imagemagick
- jdk-openjdk
- julia
- kotlin
- libgnome-keyring
- lldb(c/cpp/rust debugger)
- lua
- luacheck(lua linter)
- luarocks
- neomutt(optional)
- neovim
  - neovim-drop-in(aur, vi/vim simlink)
  - nodejs-neovim(aur)
  - python-pynvim
  - wbthomason/packer.nvim(from install script)
- netcoredbg(aur, cs debugger)
- nginx(optional)
- nodejs-jsonlint(aur, json linter)
- nodejs-lts-gallium
- nodejs-markdownlint-cli(aur, markdown linter)
- npm
- openssh
- php
- php-\*(apcu, gd, sqlite, pgsql, redis, imap, imagick, fpm)
- php-cs-fixer(aur, php formatter)
- poetry(from install script)
  - python3(poetry)
    - black(poetry)
    - debugpy(poetry)
    - flake8(poetry)
    - isort(poetry)
    - pytest(poetry)
- postfix(optional)(localhost only for neomutt)
- prettier
  (html/css/sass/javascript/typescript/react/vue/json/yaml/markdown/graphql formatter)
- pyenv(from install script)
  - python3(pyenv)
- python3
- python-black(python formatter)
- python-debugpy(python debugger)
- python-isort(python formatter)
- python-pip
- python-pytest
- ranger(optional)
- rclone(optional)
  - gdrive
  - dropbox
  - onedrive
  - pcloud
  - mega
- ripgrep
- rustup(from install script)
  - rust(rustup)
  - cargo(rustup)
- shfmt(bash formatter)
- shellcheck(bash linter)
- source-highlight
- stylelint(css linter)
- stylelint-config-standard
- stylua(lua formatter)
- sqlfluff(sql linter/formatter)
- sqlite
- tidy(html linter)
- tmux
- typescript
- w3m
- wget
- xclip
- xdebug(php debugger extension)
- yarn
- zsh

## Terminal fonts for zsh powerlevel10k

- Ricty & MesloLGS NF
- HackGenNerd

## Shell scripts

| Name            | Description                   |
| --------------- | ----------------------------- |
| rclone_mount.sh | mount cloud script.           |
| update-\*.sh    | update local package scripts. |

## Development

- bash
- bashdb
- python
- lua
- git
- nodejs
  - bash-language-server
- vscode
- neovim
