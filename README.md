# dotfiles

My dotfiles for command line interface on Arch linux.

## How to install

Run this command: `install.sh`

## Depend on

- asdf(from git clone, see: gitHub)
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
    - eslint_d(npm)
    - jsonlint(npm)
    - markdownlint-cli(npm)
    - neovim(npm)
    - prettierd(npm)
    - stylelint(npm)
    - tidy(npm)
    - typescript(npm)
    - yaml-lint(npm)
    - etc...(for development)
  - ruby(asdf)
    - bundler(gem)
- aspnet-runtime
- aspnet-targeting-pack
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
- eslint_d(for javascript/typescript/react/vue linter)
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
- neomutt
- neovim
  - neovim-drop-in(aur, vi/vim simlink)
  - nodejs-neovim(aur)
  - python-pynvim
  - wbthomason/packer.nvim(from install script, see: gitHub)
- netcoredbg(aur, cs debugger)
- nginx
- nodejs-jsonlint(aur, json linter)
- nodejs-lts-gallium
- nodejs-markdownlint-cli(aur, markdown linter)
- npm
- openssh
- php
- php-\*(apcu, gd, sqlite, pgsql, redis, imap, imagick, fpm)
- php-cs-fixer(aur, php formatter)
- poetry(from install script, see: python-poetry.org)
  - python3(poetry)
    - black(poetry)
    - debugpy(poetry)
    - flake8(poetry)
    - isort(poetry)
    - pytest(poetry)
- postfix(localhost only for neomutt)
- prettier
  (html/css/sass/javascript/typescript/react/vue/json/yaml/markdown/graphql formatter)
- pyenv(from install script, see: gitHub)
  - python3(pyenv)
- python3
- python-black(python formatter)
- python-debugpy(python debugger)
- python-isort(python formatter)
- python-pip
- python-pytest
- ranger
- rclone
  - gdrive
  - dropbox
  - onedrive
  - pcloud
  - mega
- ripgrep
- rustup(from install script, see: www.rust-lang.org)
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

| Name            | Description         |
| --------------- | ------------------- |
| rclone_mount.sh | mount cloud script. |

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
