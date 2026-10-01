OS = ubuntu
NAME ?= devbox
MEMORY ?= 8192
VCPUS ?= 8
DISK_SIZE ?= 20
IP ?= 192.168.122.100

SSH_PUBKEY := $(shell cat ~/.ssh/id_ed25519.pub)
IMAGES_DIR := /var/lib/libvirt/images/$(NAME)
IMAGE := $(IMAGES_DIR)/$(NAME).qcow2
META_DATA := $(IMAGES_DIR)/meta-data.yaml
USER_DATA := $(IMAGES_DIR)/user-data.yaml

.PHONY: install
install: network $(IMAGE)
	sed "s|__NAME__|$(NAME)|g" meta-data.yaml > $(META_DATA)
	sed "s|__SSH_PUBKEY__|$(SSH_PUBKEY)|g; s|__IP__|$(IP)|g" ubuntu-init.yaml > $(USER_DATA)
	virt-install \
		--name $(NAME) \
		--memory $(MEMORY) \
		--vcpus $(VCPUS) \
		--os-variant ubuntu24.04 \
		--disk path=$(IMAGE),size=$(DISK_SIZE),format=qcow2 \
		--network network=default \
		--console pty,target_type=serial \
		--noautoconsole \
		--graphics none \
		--import \
		--cloud-init user-data=$(USER_DATA),meta-data=$(META_DATA)

$(IMAGE):
	sudo install -d -o $$(id -un) -g $$(id -gn) -m 0755 $(IMAGES_DIR)
	cd $(IMAGES_DIR) && wget https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
	cd $(IMAGES_DIR) && qemu-img convert -p -f qcow2 -O qcow2 noble-server-cloudimg-amd64.img $(NAME).qcow2
	cd $(IMAGES_DIR) && qemu-img resize $(NAME).qcow2 $(DISK_SIZE)G

.PHONY: ubuntu
ubuntu: $(IMAGE)

.DEFAULT_GOAL := install
