install: brew shell dotfiles powerline vim

brew:
	@sh scripts/brew.sh

shell:
	@sh scripts/shell.sh

dotfiles:
	@ln -vsf ${PWD}/.profile ${HOME}/.profile
	@ln -vsf ${PWD}/.zshrc ${HOME}/.zshrc
	@ln -vsf ${PWD}/.vimrc ${HOME}/.vimrc
	@ln -vsf ${PWD}/.tmux.conf ${HOME}/.tmux.conf

powerline:
	@sh ./scripts/powerline.sh

vim:
	@sh scripts/vim.sh

macos:
	@sh scripts/macos.sh

.PHONY: install
.DEFAULT_GOAL := install
