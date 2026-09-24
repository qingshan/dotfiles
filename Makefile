GIT_NAME = Qingshan
GIT_MAIL = qs@qingshan.dev

OS := $(shell uname -s | tr A-Z a-z)

.PHONY: install
install: setup tools

.PHONY: doctor
doctor:
	@./bin/dotfiles-doctor

.PHONY: dotfiles-bootstrap
dotfiles-bootstrap:
	@mkdir -p ${HOME}/.config/mise
	@ln -snf ${HOME}/.dotfiles/mise/config.toml ${HOME}/.config/mise/config.toml

.PHONY: bootstrap
bootstrap: dotfiles-bootstrap
	mise dotfiles apply --yes ${HOME}/.config/mise/config.toml
	mise install

.PHONY: setup
setup: setup-$(OS) bootstrap
	touch ~/.hushlogin

.PHONY: setup-darwin
setup-darwin:

.PHONY: setup-linux
setup-linux:
	@if [ -f /etc/redhat-release ]; then sh ./linux/redhat/setup.sh; fi
	@if [ -f /etc/debian_version ]; then sh ./linux/debian/setup.sh; fi
	@if command -v omarchy >/dev/null 2>&1; then sh ./linux/omarchy/setup.sh; fi

.PHONY: tools
tools: shells tmux herdr git vim zk dirs

.PHONY: shells
shells: dotfiles-bootstrap
	mise dotfiles apply --yes \
		${HOME}/.profile \
		${HOME}/.bashrc ${HOME}/.bash_profile \
		${HOME}/.zshrc ${HOME}/.zprofile \
		${HOME}/.config/fish/config.fish ${HOME}/.config/lsd/config.yml ${HOME}/.config/starship.toml

.PHONY: tmux
tmux: dotfiles-bootstrap
	mise dotfiles apply --yes ${HOME}/.config/tmux/tmux.conf

.PHONY: herdr
herdr: dotfiles-bootstrap
	mise dotfiles apply --yes ${HOME}/.config/herdr/config.toml

.PHONY: git
git:
	git config --global user.name $(GIT_NAME)
	git config --global user.email $(GIT_MAIL)
	git config --global push.default current

.PHONY: vim
vim: dotfiles-bootstrap
	mise dotfiles apply --yes ${HOME}/.vimrc
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +PlugInstall +qall
	nvim --headless "+Lazy! update" +qa

.PHONY: zk
zk: dotfiles-bootstrap
	mise dotfiles apply --yes ${HOME}/.config/zk

.PHONY: dirs
dirs:
	@test -d ~/.bin || mkdir -v ~/.bin
	@test -d ~/code || mkdir -v ~/code
	@test -d ~/work || mkdir -v ~/work

.PHONY: tailscale
tailscale: tailscale-$(OS)
	sudo tailscale up

.PHONY: tailscale-darwin
tailscale-darwin:
	brew install tailscale
	sudo brew services start tailscale

.PHONY: tailscale-linux
tailscale-linux:
	curl -fsSL https://tailscale.com/install.sh | sh
	sudo systemctl enable --now tailscaled

.PHONY: desktop
desktop: desktop-$(OS)

.PHONY: terminal
terminal: alacritty ghostty

.PHONY: alacritty
alacritty: dotfiles-bootstrap
	mise dotfiles apply --yes ${HOME}/.config/alacritty/alacritty.toml

.PHONY: ghostty
ghostty: dotfiles-bootstrap
	mise dotfiles apply --yes ${HOME}/.config/ghostty/config

.PHONY: editor
editor: ideavim

.PHONY: ideavim
ideavim: dotfiles-bootstrap
	mise dotfiles apply --yes ${HOME}/.config/ideavim/ideavimrc

.PHONY: skhd
skhd: dotfiles-bootstrap
	mise dotfiles apply --yes ${HOME}/.config/skhd/skhdrc
	brew install asmvik/formulae/skhd
	skhd --start-service

.PHONY: desktop-darwin
desktop-darwin: terminal editor skhd
	@sh ./macos/setup.sh

.PHONY: desktop-linux
desktop-linux: terminal editor
	@if command -v omarchy >/dev/null 2>&1; then sh ./omarchy/setup.sh; fi

.PHONY: test
test: server-test desktop-test

.PHONY: server-test
server-test:
	make -C ./deploy/devpod server-test

.PHONY: desktop-test
desktop-test:
	make -C ./deploy/devpod desktop-test

.DEFAULT_GOAL := install
