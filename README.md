# dotfiles

My dotfiles for command-line interface on Arch linux.

## Overview

![overview](https://user-images.githubusercontent.com/48638671/171588449-9a133364-cb2b-4423-a661-0510a0940431.png)

## How to Install

gnome-keyring settings required.

See: [Wiki](https://github.com/Lamtea/dotfiles/wiki/gnome-keyring)

```bash
paru -S <dependent packages>
# Install arch packages and aur packages(see below `Depend on` list).
# Options can be ignored.
# If you want to use cloud such as dropbox, gdrive, etc..,
# setup rclone(see: Arch wiki) and edit ./bin/rclone_mount.sh.
# (In my case run on i3 startup)
# nginx is used to check debugging using pathmappings, for example in PHP (even docker).
# ranger is a vim-like filer.
# Use neomutt and postfix in local mail delivery(See Arch wiki for postfix settings).
# (In my case I use it to logwatch and notify system errors from services.)
# (Also, it is not used in wsl.)
```

```bash
cd ~
git clone --depth 1 https://github.com/wbthomason/packer.nvim .local/share/nvim/site/pack/packer/start/packer.nvim
# If you fail, make sure the way may have changed(see: github).
git clone https://github.com/Lamtea/dotfiles.git .dotfiles
```

```bash
cd .dotfiles
vi .gitconfig
  email = <your email address>
  name = <your user name>
vi .config/neomutt/neomuttrc
  set my_name="<your name>"
# For localization, see below `Localization`.
```

```bash
./install.sh
```

```bash
exec zsh
# Install zsh plugins and some packages from github or script.
# If you are not using zsh, run `chsh -s /usr/bin/zsh'.
```

```bash
sudo archlinux-java set java-18-openjdk
~/bin/update-devtools.sh
sudo archlinux-java set <your jdk version>
# Install asdf tools, dotnet tools, pyenv, poetry, ghcup, rustup,
# vscode extensions, language servers, neovim nightly, etc...
# If you fail, make sure the way may have changed(See: github).
```

```bash
vi +PackerSync
   :helptags ALL
   :LspInstallInfo
   :checkhealth
# Install neovim plugins and create helptags,
# and install lsp in your programming languages
# (if you are unsure, see below `neovim Language Servers` list).
# Finally, All OK except WARNING from Whichkey.
# (No problem because it is an extension of the standard command)
```

## neovim Plugins

See: [neovim Plugins used in my dotfiles](https://github.com/stars/Lamtea/lists/neovim-plugins)

## neovim Language Servers

See: [neovim Language Servers I use](https://github.com/stars/Lamtea/lists/neovim-language-servers)

## neovim Hello World

See: [Wiki](https://github.com/Lamtea/dotfiles/wiki/neovim#hello-world)

## Depend on

- android-apktool _(aur)_
- android-platform _(aur)_
- android-sdk _(aur)_
- android-sdk-build-tools _(aur)_
- android-sdk-cmdline-tools-latest _(aur)_
- android-sdk-platform-tools _(aur)_
- android-tools
- android-udev-git _(aur)_
- asdf **(from github)**
  - dart _(asdf)_
  - deno _(asdf)_
  - dotnet _(asdf)_
  - flutter _(asdf)_
  - golang _(asdf)_
    - delve _(go install)_
  - golangci-lint _(asdf, go linter)_
  - hadolint _(asdf, dockerfile linter)_
  - ktlint _(asdf, kotlin linter/formatter)_
  - neovim _(asdf)_
  - nodejs _(asdf)_
    - eslint _(npm)_
    - jsonlint _(npm)_
    - markdownlint-cli _(npm)_
    - neovim _(npm)_
    - prettier _(npm)_
    - stylelint _(npm)_
    - typescript _(npm)_
    - etc... _(for development)_
  - ruby _(asdf)_
    - bundler _(gem)_
- aspnet-runtime
- aspnet-targeting-pack
- base-devel
- bashdb _(aur)_
- bemenu
- clang
- cmake
- codespell _(spell linter/formatter)_
- composer
- colordiff
- cppcheck _(c/cpp linter)_
- dart
- dart-sass
- delve _(go debugger)_
- deno
- dotnet-host
- dotnet-runtime
- dotnet-sdk
- dotnet-targeting-pack
- editorconfig-checker _(editorconfig linter)_
- eslint _(javascript/typescript/react/vue linter)_
- fd
- flake8 _(python linter)_
- fzf
- gawk
- ghcup-hs-bin _(aur)_
  - ghc _(ghcup)_
  - hls _(ghcup)_
  - stack _(ghcup)_
- git
- github-cli
- gnome-keyring
- go
- google-java-format _(aur, java formatter)_
- gradle
- imagemagick
- jdk-openjdk
- jdk11-openjdk
- jdk17-openjdk
- julia
- kotlin
- language-server
  - jdtls _(for nvim-jdtls, download latest)_
    - lombok _(download latest)_
- libgnome-keyring
- lldb _(c/cpp/rust debugger)_
- lua
- luacheck _(lua linter)_
- luarocks
- maven
- neomutt **(optional)**
- neovim
  - neovim-drop-in _(aur, vi/vim simlink)_
  - nodejs-neovim _(aur)_
  - python-pynvim
  - wbthomason/packer.nvim **(from install script)**
- netcoredbg _(aur, csharp debugger)_
- nginx **(optional)**
- ninja
- nodejs-jsonlint _(aur, json linter)_
- nodejs-lts-gallium
- nodejs-markdownlint-cli _(aur, markdown linter)_
- npm
- openssh
- php
- php-\* (apcu, gd, sqlite, pgsql, redis, imap, imagick, fpm)
- php-cs-fixer _(aur, php formatter)_
- poetry **(from install script)**
  - black _(poetry)_
  - debugpy _(poetry)_
  - flake8 _(poetry)_
  - isort _(poetry)_
  - pytest _(poetry)_
- postfix **(optional)** _(localhost only for neomutt)_
- prettier
  _(html/css/sass/javascript/typescript/react/vue/json/yaml/markdown/graphql formatter)_
- pyenv **(from install script)**
  - python3 _(pyenv)_
- python3
- python-black _(python formatter)_
- python-debugpy _(python debugger)_
- python-isort _(python formatter)_
- python-pytest
- ranger **(optional)**
- rclone **(optional)**
  - gdrive
  - dropbox
  - onedrive
  - pcloud
  - mega
- ripgrep
- rustup **(from install script)**
  - rust _(rustup)_
  - cargo _(rustup)_
- shfmt _(bash formatter)_
- shellcheck _(bash linter)_
- source-highlight
- stylelint _(css linter)_
- stylua _(lua formatter)_
- sqlfluff _(sql linter/formatter)_
- sqlite
- tidy _(html linter)_
- tmux
- typescript
- vscode extensions **(from github)**
  - vscode-node-debug2
  - vscode-chrome-debug
  - vscode-firefox-debug
  - vscode-php-debug
  - java-debug
  - vscode-java-test
  - kotlin-debug-adapter
- w3m
- wget
- xclip
  **(optional)**
  _(I use Linux Desktop Environment so this is it, see `:h clipboard` in nvim)_
- xdebug _(php debugger extension)_
- yarn
- zsh

## Localization

- Edit `.zshrc`
  - `export LANG=ja_JP.UTF-8` # change your locale
- Edit `.config/nvim/lua/plugins/sidebar.lua`
  - `datetime` section
    - `format = "%b %d??? (%a) %H:%M"` # change your locale
- There is **fcitx5** setting in `.config/nvim/lua/command.lua`
  - It works installed _(it won't work unless)_.
    - If you are ibus user, edit to your setting.

## Terminal Fonts for zsh powerlevel10k

- For Japanese
  - Ricty & MesloLGS NF
  - HackGenNerd

## Shell Scripts

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
