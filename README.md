# dotfiles

My dotfiles for command-line interface on Arch linux.

## Overview

![overview](https://user-images.githubusercontent.com/48638671/171588449-9a133364-cb2b-4423-a661-0510a0940431.png)

## How to Install

gnome-keyring settings required.

See: [Wiki](https://github.com/Lamtea/dotfiles/wiki/gnome-keyring)

```bash
# Install arch official packages and aur packages(see below `Depend on` list).
# Options can be ignored.
# If you want to use cloud such as dropbox, gdrive, etc..,
# setup rclone(see: Arch wiki) and edit ./bin/rclone_mount.sh.
# (In my case run on i3 startup)
# nginx is used to check debugging using path mappings, for example in PHP (even docker).
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
# Install rustup, ghcup, mise tools, ruby bundle, php composer, etc...
# If you fail, make sure the way may have changed(See: github).
~/bin/update-devtools.sh
source ~/.zshrc
```

```bash
# Add rust components.
rustup component add clippy llvm-tools rls rust-analysis rust-analyzer rust-docs rust-src rustfmt
```

```bash
# Set ghc, hls, stack.
ghcup tui
# Install haskell packages.
stack install haskell-dap ghci-dap haskell-debug-adapter hlint apply-refact fourmolu
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

## Container **(optional)**

### Docker

See: [Arch Wiki - Docker](https://wiki.archlinux.org/title/Docker)

## Kubernetes **(optional)**

### Minikube

See: [Arch Wiki - Minikube](https://wiki.archlinux.org/title/Minikube)

### Kind

See: [github - kind](https://github.com/kubernetes-sigs/kind)

## Neovim

### Neovim Plugins, LSP, DAP

See: [Wiki](https://github.com/Lamtea/dotfiles/wiki/neovim#introduction)

### Neovim Hello World

See: [Wiki](https://github.com/Lamtea/dotfiles/wiki/neovim#hello-world)

## Depend on

### Official

- android-tools
- android-udev
- aspnet-runtime
- aspnet-targeting-pack
- azure-cli
- bemenu
- certbot
  - certbot-nginx **(optional)**
  - certbot-dns-cloudflare
- clang
- colordiff
- cppcheck
- curl
- docker **(optional)**
  - docker-buildx
  - docker-compose
  - docker-rootless-extras
  - nvidia-container-toolkit **(optional)** _(for NVIDIA CUDA user)_
- dotnet-host
- dotnet-runtime
- dotnet-sdk
- dotnet-targeting-pack
- git
- gnome-keyring
  - libsecret
- groovy
- jdk-openjdk
- lldb
- lua
- luacheck
- luajit
- luarocks
- minikube **(optional)**
  - argocd
  - istio
  - kubernetes-tools
  - helm
  - helmfile
- neomutt **(optional)**
- neovim
  - python-pynvim
- nginx **(optional)**
- openssh
- php
- php-\* (apcu, gd, sqlite, pgsql, redis, imagick, fpm)
- postfix **(optional)** _(localhost only for neomutt)_
- python3
- ranger **(optional)**
- rclone **(optional)**
  - gdrive
  - dropbox
  - onedrive
  - pcloud
  - mega
- source-highlight
- sqlite
- tidy
- w3m
- xclip
  **(optional)**
  _(I use Linux Desktop Environment so this is it, see `:h clipboard` in nvim)_
- xdebug
- zsh
- zshdb

### AUR

- android-apktool
- azcopy
- azure-functions-core-tools
- bashdb
- codelldb
- debtap
- google-java-format
- jdk
- neovim-drop-in
- yay

### From install script

- ghcup
  - ghc
  - hls
  - stack
    - haskell-debug-adapter
      - haskell-dap
      - ghci-dap
    - hlint
      - apply-refact
    - fourmolu
- mise
  - actionlint
  - biome
  - buf
  - bun
  - checkmake
  - cmake
  - dart
  - delta
  - deno
  - dotnet _(official)_
    - csharpier
    - dotnet-aspnet-codegenerator
    - dotnet-ef
    - dotnet-outdated-tool
    - dotnet-reportgenerator-globaltool
    - linux-dev-certs
    - powershell
    - roslynator.dotnet.cli
  - dprint
  - eza
  - fd
  - flutter
  - fzf
  - github-cli
  - gitui
  - go
    - delve
  - golangci-lint
  - gradle
  - groovy _(local)_
  - hadolint
  - java _(local)_
  - jq
  - jwt
  - jwtui
  - kind
  - kotlin
  - ktlint
  - lua _(local)_
  - maven
  - neovim
  - node
    - @antfu/ni
    - @devcontainers/cli
    - neovim
    - prettier
    - sass
    - yarn
  - php _(see also: [composer.json](./composer.json))_
  - protoc
  - python _(local, see also: [.default_python_packages](./.default-python-packages))_
    - debugpy
    - cmakelang
    - codespell
    - cpplint
    - flawfinder
    - pipx
    - pytest
    - python-build
    - sqlfluff
  - ripgrep
  - ruby _(see also: [GemFile](./Gemfile))_
  - ruff
  - rye
  - shfmt
  - shellcheck
  - stylua
  - terraform
  - tfsec
  - tmux
  - tree-sitter
  - uv
  - yamllint
  - yq
- rustup
  - cargo
    - cargo-binstall
    - cargo-cache
    - cargo-update
    - cargo-watch
    - jaq
  - clippy
  - llvm-tools
  - rls
  - rust-analysis
  - rust-analyzer
  - rust-docs
  - rust-src
  - rust
  - rustc
  - rustfmt

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
  - Moralerspace Neon HWNF
  - HackGen Console NF

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
