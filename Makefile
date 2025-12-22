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
	ln -vsf .dotfiles/.profile ${HOME}/.profile

.PHONY: bash
bash: profile
	ln -vsf .dotfiles/.bashrc ${HOME}/.bashrc
	ln -vsf .dotfiles/.bash_profile ${HOME}/.bash_profile

.PHONY: zsh
zsh: profile
	ln -vsf .dotfiles/.zshrc ${HOME}/.zshrc
	ln -vsf .dotfiles/.zprofile ${HOME}/.zprofile

.PHONY: fish
fish:
	mkdir -p ${HOME}/.config/fish
	ln -vsf ../../.dotfiles/fish/config.fish ${HOME}/.config/fish/config.fish
	fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
	fish -c "fisher install patrickf1/fzf.fish"
	fish -c "fisher install jorgebucaran/autopair.fish"

.PHONY: tools
tools: vim tmux git dirs

.PHONY: vim
vim:
	ln -vsf .dotfiles/.vimrc ${HOME}/.vimrc
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +PlugInstall +qall

.PHONY: tmux
tmux:
	ln -vsf .dotfiles/.tmux.conf ${HOME}/.tmux.conf

.PHONY: git
git:
	git config --global user.name $(GIT_NAME)
	git config --global user.email $(GIT_MAIL)
	git config --global push.default current

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
	ln -vsf ../../.dotfiles/alacritty/$(OS)_alacritty.toml ${HOME}/.config/alacritty/alacritty.toml

.PHONY: ghostty
ghostty:
	mkdir -p ${HOME}/.config/ghostty
	ln -vsf ../../.dotfiles/ghostty/config ${HOME}/.config/ghostty/config

.PHONY: desktop-darwin
desktop-darwin: terminal
	@sh ./macos/setup.sh

.PHONY: desktop-linux
desktop-linux: terminal
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
