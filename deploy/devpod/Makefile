DOCKER ?= $(shell if command -v container >/dev/null 2>&1; then echo "container"; else echo "docker"; fi)
REPO_ROOT := $(abspath ../..)

.PHONY: test server-image desktop-image server-test desktop-test
# Share image preparation and run SSH tests sequentially.
.NOTPARALLEL:
test: server-test desktop-test

server-image:
	$(DOCKER) build -t dotfiles-server -f "$(CURDIR)/Dockerfile.server" "$(REPO_ROOT)"

desktop-image: server-image
	$(DOCKER) build -t dotfiles-desktop -f "$(CURDIR)/Dockerfile.desktop" "$(REPO_ROOT)"

server-test: server-image
	DOCKER="$(DOCKER)" bash ./test.sh dotfiles-server server

desktop-test: desktop-image
	DOCKER="$(DOCKER)" bash ./test.sh dotfiles-desktop desktop

.DEFAULT_GOAL := test
