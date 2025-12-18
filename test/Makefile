DOCKER := $(shell if command -v container >/dev/null 2>&1; then echo "container"; else echo "docker"; fi)

.PHONY: test
test: docker-test debian-test

docker-test:
	cd ~/.dotfiles/test
	$(DOCKER) build -t dotbox .
	$(DOCKER) run --name dotbox -h dotbox -d --rm -p 8022:22 dotbox
	sleep 1
	ssh -q -i id_rsa -p 8022 qingshan@127.0.0.1 -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null" "rustup show"
	$(DOCKER) stop dotbox

.PHONY: debian-test
debian-test:

.DEFAULT_GOAL := install
