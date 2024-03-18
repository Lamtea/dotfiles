# dotfiles

My dotfiles for command-line interface on Arch linux.

## Overview

![overview](https://user-images.githubusercontent.com/48638671/171588449-9a133364-cb2b-4423-a661-0510a0940431.png)

## How to Install

gnome-keyring settings required.

See: [Wiki](https://github.com/Lamtea/dotfiles/wiki/gnome-keyring)

```bash
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
yay -S <dependent packages>
```

```bash
cd ~
# If you fail, make sure the way may have changed(see: github).
git clone --depth 1 https://github.com/wbthomason/packer.nvim .local/share/nvim/site/pack/packer/start/packer.nvim
git clone https://github.com/Lamtea/dotfiles.git .dotfiles
```

```bash
cd .dotfiles
vi .gitconfig
  email = <your email address>
  name = <your user name>
# For localization, see below `Localization`.
vi .config/neomutt/neomuttrc
  set my_name="<your name>"
```

```bash
./install.sh
```

```bash
# Install zsh plugins and some packages from github or script.
# If you are not using zsh, run `chsh -s /usr/bin/zsh'.
exec zsh
```

```bash
# Install mise tools, poetry, rustup, ghcup, ruby bundle, dotnet tools.
# If you fail, make sure the way may have changed(See: github).
~/bin/update-devtools.sh
```

```bash
# Install neovim plugins and create helptags,
# and install lsp, dap in your programming languages
# (if you are unsure, see below `neovim Plugins, LSP, DAP` list).
# Finally, All OK except WARNING from Whichkey.
# (No problem because it is an extension of the standard command)
vi +PackerSync
   :helptags ALL
   :Mason
   :checkhealth
```

## Containers **(optional)**

### Docker

See: [Arch Wiki - Docker](https://wiki.archlinux.org/title/Docker)

### Containerd

See: [gitHub - containerd](https://github.com/containerd/containerd)

See: [gitHub - nerdctl](https://github.com/containerd/nerdctl)

### Minikube

See: [Arch Wiki - Minikube](https://wiki.archlinux.org/title/Minikube)

### Kind

See: [github - kind](https://github.com/kubernetes-sigs/kind)

## neovim Plugins, LSP, DAP

See: [Wiki](https://github.com/Lamtea/dotfiles/wiki/neovim#introduction)

## neovim Hello World

See: [Wiki](https://github.com/Lamtea/dotfiles/wiki/neovim#hello-world)

## Depend on

- actionlint _(github actions linter)_
- android-apktool _(aur)_
- android-platform _(aur)_
- android-sdk _(aur)_
- android-sdk-build-tools _(aur)_
- android-sdk-cmdline-tools-latest _(aur)_
- android-sdk-platform-tools _(aur)_
- android-tools
- android-udev
- mise **(from install script)**
  - dart _(global, latest)_
  - deno _(local)_
  - dotnet _(global, latest)_
  - flutter _(global, latest)_
  - golang _(local)_
    - delve
  - golangci-lint _(global, latest, go linter)_
  - hadolint _(global, latest, dockerfile linter)_
  - ktlint _(global, latest, kotlin linter/formatter)_
  - neovim _(global, stable)_
  - nodejs _(local)_
    - devcontainers/cli
    - markdownlint-cli2
    - neovim
    - npm-check-updates
    - prettier
  - python _(local)_
    - debugpy
    - neovim
  - ruby _(global, latest)_
    - bundler
- aspnet-runtime
- aspnet-targeting-pack
- azure-cli _(aur)_
- azure-functions-core-tools _(aur)_
- base-devel
- bashdb _(aur)_
- bemenu
- buf
- certbot
  - certbot-nginx
  - certbot-dns-cloudflare
- checkmake _(aur, make linter)_
- clang
- cmake
- cmake-language-server _(aur, cmake linter/formatter)_
- codespell _(spell linter/formatter)_
- composer
- containerd **(optional)**
  - nerdctl
  - buildkit
  - cni-plugins
  - rootlesskit
  - slir4netns
- colordiff
- cppcheck _(c/cpp linter)_
- dart-sass
- delve _(go debugger)_
- deno
- devcontainer-cli _(aur)_
- debtap _(aur)_
- docker **(optional)**
  - docker-buildx
  - docker-compose
  - nvidia-container-toolkit _(aur, for NVIDIA CUDA user, also available in containerd)_
- dotnet-host
- dotnet-runtime
- dotnet-sdk
- dotnet-targeting-pack
- editorconfig-checker _(editorconfig linter)_
- fd
- flake8 _(python linter)_
- fzf
- gawk
- ghcup _(from install script)_
  - ghc
  - hls
  - stack
    - haskell-dap
    - ghci-dap
    - haskell-debug-adapter
    - hlint
    - apply-refact
    - fourmolu
- git
- github-cli
- gnome-keyring
- go
- google-java-format _(aur, java formatter)_
- gradle
- grpcurl-bin _(aur)_
- imagemagick
- jdk-openjdk
- jdk11-openjdk
- jdk17-openjdk
- julia
- kotlin
- libgnome-keyring
- lldb _(c/cpp/rust debugger)_
- lua
- luacheck _(lua linter)_
- luarocks
- markdownlint-cli2 _(markdown linter)_
- maven
- minikube **(optional)**, kind-bin **(optional)** _(aur)_
  - argocd
  - istio
  - kubernetes-tools
  - helm
  - helmfile
- neomutt **(optional)**
- neovim
  - neovim-drop-in _(aur, vi/vim simlink)_
  - nodejs-neovim _(aur)_
  - python-pynvim
  - wbthomason/packer.nvim **(from install script)**
- nginx **(optional)**
- ninja
- nodejs-jsonlint _(aur, json linter)_
- nodejs-lts-hydrogen
- npm
- npm-check-updates
- openssh
- php
- php-\* (apcu, gd, sqlite, pgsql, redis, imagick, fpm)
- php-cs-fixer _(aur, php formatter)_
- poetry **(from install script)**
  - black
  - debugpy
  - flake8
  - isort
  - pytest
- postfix **(optional)** _(localhost only for neomutt)_
- prettier
  _(html/css/sass/javascript/typescript/react/vue/json/yaml/markdown/graphql formatter)_
- protobuf
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
- rust
- rustup **(from install script)**
  - rust
  - cargo
- shfmt _(bash formatter)_
- shellcheck _(bash linter)_
- source-highlight
- stylua _(lua formatter)_
- sqlfluff _(sql linter/formatter)_
- sqlite
- terraform
- tfsec _(aur, terraform linter)_
- tidy _(html linter)_
- tmux
- tree-sitter-cli
- w3m
- wget
- xclip
  **(optional)**
  _(I use Linux Desktop Environment so this is it, see `:h clipboard` in nvim)_
- xdebug _(php debugger extension)_
- yarn
- yay _(aur)_
- zsh

## Localization

- Edit `.zshrc`
  - `export LANG=ja_JP.UTF-8` # change your locale
- Edit `.config/nvim/lua/plugins/sidebar.lua`
  - `datetime` section
    - `format = "%b %d日 (%a) %H:%M"` # change your locale
- There is **fcitx5** setting in `.config/nvim/lua/command.lua`
  - It works installed _(it won't work unless)_.
    - If you are ibus user, edit to your setting.

## Terminal Fonts for zsh powerlevel10k

- For Japanese
  - Ricty & MesloLGS NF
  - HackGenNerd

## Scripts

| Name            | Description                   |
| --------------- | ----------------------------- |
| rclone_mount.sh | mount cloud script.           |
| update-\*.sh    | update local package scripts. |

## Develop Environment

- bash
- zsh
- python
- lua
- git
- neovim
