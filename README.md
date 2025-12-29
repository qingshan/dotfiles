# Qingshan's Dotfiles

Dotfiles are for macOS and Linux to setup my development environment.

## Installation

Install dotfiles, run:

```shell
git clone https://github.com/qingshan/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make
```

For macOS or Debian desktop, one more step:

```shell
make desktop
```

## Features

### Desktops

- [macOS](macos/README.md)
- [Debian](debian/README.md): regolith-i3 & xremap & xmodmap

Both desktops use same key bindigs, go to [Desktop Cheatsheet](docs/desktop_cheatsheet.md).

### Servers

- Debian, Ubuntu
- Rocky Linux, CentOS, RedHat Enterprise Linux
- Arch Linux

### Shells

zsh as default shell on macOS:
- `~/.zprofile` and `~/.profile` is sourced in login shell.
- `~/.zshrc` is sourced in interactive shell.

bash as default shell on macOS:
- `~/.bash_profile` and `~/.profile` is sourced in login shell.
- `~/.bashrc` is sourced in interactive shell.

fish as interactive shell in interactive mode of zsh or bash, without setting it as user's default shell.

### Terminals

- alacritty, ghostty, ssh runs user's default shell as interactive login shell.
- tmux runs inside an existing shell session, runs fish as interactive non-login shell.

alacritty as default terminal integrated with tmux, go to [Terminal Cheatsheet](https://qingshan.dev/posts/alacritty-integration-with-tmux/) for key bindings.

ghosttty as quick terminal.

### SSH

- `ssh server` starts interactive login shell.
- `ssh server command` non-interactive non-login shell.
- `echo command | ssh server` starts non-interactive login shell. You can also start one with `ssh server bash -l -c command`.

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

- zk for cli notes: journal/inbox/notes
- Obsidian for tech notes
- Apple Notes for personal notes
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
