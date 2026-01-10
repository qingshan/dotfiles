GIT_NAME = Qingshan
GIT_MAIL = qs@qingshan.dev

OS := $(shell uname -s | tr A-Z a-z)

.PHONY: install
install: setup shells tools packages

.PHONY: setup
setup: setup-$(OS)
	touch ~/.hushlogin

.PHONY: setup-darwin
setup-darwin:

.PHONY: setup-linux
setup-linux:
	@if [ -f /etc/redhat-release ]; then sh ./linux/redhat/setup.sh; fi
	@if [ -f /etc/arch-release ]; then sh ./linux/arch/setup.sh; fi
	@if [ -f /etc/debian_version ]; then sh ./linux/debian/setup.sh; fi

.PHONY: shells
shells: bash zsh fish

.PHONY: profile
profile:
	ln -snf .dotfiles/.profile ${HOME}/.profile

.PHONY: bash
bash: profile
	ln -snf .dotfiles/.bashrc ${HOME}/.bashrc
	ln -snf .dotfiles/.bash_profile ${HOME}/.bash_profile

.PHONY: zsh
zsh: profile
	ln -snf .dotfiles/.zshrc ${HOME}/.zshrc
	ln -snf .dotfiles/.zprofile ${HOME}/.zprofile

.PHONY: fish
fish:
	mkdir -p ${HOME}/.config/fish
	mkdir -p ${HOME}/.config/lsd
	ln -snf ../../.dotfiles/fish/config.fish ${HOME}/.config/fish/config.fish
	ln -snf ../../.dotfiles/lsd/config.yml ${HOME}/.config/lsd/config.yml
	ln -snf ../.dotfiles/starship/starship.toml ${HOME}/.config/starship.toml
	fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
	fish -c "fisher install patrickf1/fzf.fish"
	fish -c "fisher install jorgebucaran/autopair.fish"

.PHONY: tools
tools: vim tmux git zk dirs

.PHONY: vim
vim:
	ln -snf .dotfiles/.vimrc ${HOME}/.vimrc
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +PlugInstall +qall

.PHONY: tmux
tmux:
	ln -snf .dotfiles/.tmux.conf ${HOME}/.tmux.conf

.PHONY: git
git:
	git config --global user.name $(GIT_NAME)
	git config --global user.email $(GIT_MAIL)
	git config --global push.default current

.PHONY: zk
zk:
	ln -snf .dotfiles/zk ${HOME}/.config/zk

.PHONY: dirs
dirs:
	@test -d ~/.bin || mkdir -v ~/.bin

.PHONY: packages
packages: python-packages node-packages rust-packages

.PHONY: python-packages
python-packages:

.PHONY: node-packages
node-packages:

.PHONY: rust-packages
rust-packages:
	rustup toolchain install stable
	rustup default stable
	rustup component add rust-src
	rustup component add rust-analyzer

.PHONY: desktop
desktop: desktop-$(OS)

.PHONY: terminal
terminal: alacritty ghostty

.PHONY: alacritty
alacritty:
	mkdir -p ${HOME}/.config/alacritty
	ln -snf ../../.dotfiles/alacritty/$(OS)_alacritty.toml ${HOME}/.config/alacritty/alacritty.toml

.PHONY: ghostty
ghostty:
	mkdir -p ${HOME}/.config/ghostty
	ln -snf ../../.dotfiles/ghostty/config ${HOME}/.config/ghostty/config

.PHONY: editor
editor: ideavim

.PHONY: ideavim
ideavim:
	mkdir -p ${HOME}/.config/ideavim
	ln -snf ../.dotfiles/ideavim/ideavimrc ${HOME}/.config/ideavim/ideavimrc

.PHONY: desktop-darwin
desktop-darwin: terminal editor
	@sh ./macos/setup.sh

.PHONY: desktop-linux
desktop-linux: terminal editor
	@if [ -f /etc/debian_version ]; then sh ./debian/setup.sh; fi

.PHONY: test
test: server-test desktop-test

.PHONY: server-test
server-test:
	make -C ./test server-test

.PHONY: desktop-test
desktop-test:
	make -C ./test desktop-test

.DEFAULT_GOAL := install
