OS = ubuntu
SSH_PUBKEY := $(shell cat ~/.ssh/id_ed25519.pub)
IMAGES_DIR := /var/lib/libvirt/images/devbox
IMAGE := $(IMAGES_DIR)/devbox.qcow2

.PHONY: install
install: network $(IMAGE)
	virt-install \
		--name devbox \
		--memory 8192 \
		--vcpus 8 \
		--os-variant ubuntu24.04 \
		--disk path=$(IMAGE),size=20,format=qcow2 \
		--network network=default \
		--console pty,target_type=serial \
		--noautoconsole \
		--graphics none \
		--import \
		--cloud-init user-data=user-data.yaml,meta-data=meta-data.yaml

$(IMAGE):
	sudo install -d -o $$(id -un) -g $$(id -gn) -m 0755 $(IMAGES_DIR)
	cd $(IMAGES_DIR) && wget https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
	cd $(IMAGES_DIR) && qemu-img convert -p -f qcow2 -O qcow2 noble-server-cloudimg-amd64.img devbox.qcow2
	cd $(IMAGES_DIR) && qemu-img resize devbox.qcow2 20G
	cat ~/.dotfiles/deploy/devbox/ubuntu-init.yaml | sed "s/__SSH_PUBKEY__/$(SSH_PUBKEY)/g" > user-data.yaml

.PHONY: ubuntu
ubuntu: $(IMAGE)

.DEFAULT_GOAL := install
