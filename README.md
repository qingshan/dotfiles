# Qingshan's Dotfiles

Dotfiles are for macOS and Linux to setup my development environment.

## Installation

```shell
git clone https://github.com/qingshan/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make
```

## Features

### Desktops

- [macOS](macos/README.md)
- [Debian](debian/README.md): regolith-i3 & xremap & xmodmap

Both desktops use same key bindigs, go to [Desktop Cheatsheet](docs/desktop_cheatsheet.md).

### Servers

- Debian, Ubuntu
- Rocky Linux, CentOS, RedHat Enterprise Linux
- Arch Linux, Manjaro

### Shells

zsh as default shell on macOS:
- `.zshenv` is sourced on all invocations of the shell.
- `.zprofile` is sourced in login shells.
- `.zshrc` is sourced in interactive shells.

bash as default shell on macOS:
- `.bash_profile` is sourced in login shells.
- `.bashrc` is sourced in interactive non-login shells.

`.profile` is sourced in login shells for both bash and zsh.

fish as interactive shell in interactive mode of zsh or bash, without setting it as the default shell.

### Terminals

- alacritty will launch tmux.
- ghostty, tmux, ssh and other terminals will launch login shell (`$SHELL`) and interactive shell (fish).

For key bindings, go to [Terminal Cheatsheet](https://qingshan.dev/posts/alacritty-integration-with-tmux/)

### Tools

- bat
- fd
- lsd
- fzf
- direnv
- ripgrip
- starship
- gh
- lazygit
- zoxide
- jq
- just

### Notes

- mdbook for publish notes: [qingshan/notes](https://github.com/qingshan/notes)

### Development Environments

- Java: IntelliJ IDEA with IdeaVim
- Rust: Zed

### Fonts

- JetBrains Mono Font
- Nerd Font

### Vim
- [Vim Cheatsheet](docs/vim_cheatsheet.md)
- [Vim Plugins](docs/vim_plugins.md)
- [IdeaVim](docs/ideavim.md)

## Test

Use Docker on Linux or Apple container on macOS to build `linux/debian/Dockkerfile` to test dotfiles on latest version of Debian.

run server test
```shell
make server-test
```

or run desktop test
```shell
make deskop-test
```
