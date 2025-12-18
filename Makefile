GIT_NAME = Qingshan
GIT_MAIL = qs@qingshan.dev

OS := $(shell uname -s | tr A-Z a-z)


.PHONY: install
install: setup tools packages

.PHONY: setup
setup: setup-$(OS)

.PHONY: setup-darwin
setup-darwin:
	@sh ./macos/setup.sh

.PHONY: setup-linux
setup-linux:
	@if [ -f /etc/redhat-release ]; then sh ./linux/redhat/setup.sh; fi
	@if [ -f /etc/arch-release ]; then sh ./linux/arch/setup.sh; fi
	@if [ -f /etc/debian_version ]; then sh ./linux/debian/setup.sh; fi
	touch ~/.hushlogin

.PHONY: desktop
desktop: desktop-$(OS)

.PHONY: alacritty
alacritty:
	mkdir -p ${HOME}/.config/alacritty
	ln -vsf ../../.dotfiles/alacritty/alacritty.toml ${HOME}/.config/alacritty/alacritty.toml

.PHONY: desktop-darwin
desktop-darwin: alacritty

.PHONY: desktop-linux
desktop-linux: alacritty
	@if [ -f /etc/debian_version ]; then sh ./debian/setup.sh; fi

.PHONY: packages
packages: python-packages node-packages rust-packages fish-packages

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

.PHONY: fish-packages
fish-packages:
	fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
	fish -c "fisher install patrickf1/fzf.fish"
	fish -c "fisher install jorgebucaran/autopair.fish"

.PHONY: tools
tools: fish bash vim tmux git dirs

.PHONY: profile
profile:
	ln -vsf .dotfiles/.profile ${HOME}/.profile

.PHONY: fish
fish: profile
	mkdir -p ${HOME}/.config/fish
	ln -vsf ../../.dotfiles/fish/config.fish ${HOME}/.config/fish/config.fish

.PHONY: bash
bash: profile
	ln -vsf .dotfiles/.bashrc ${HOME}/.bashrc

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

.PHONY: test
test: docker-test debian-test

.PHONY: docker-test
docker-test:
	make -C ./test docker-test

.PHONY: debian-test
debian-test:
	make -C ./test debian-test

.DEFAULT_GOAL := install
