#!/usr/bin/sh

sudo dnf update -y
sudo dnf install -y epel-release
sudo dnf install -y make \
  fish \
  curl \
  git \
  vim \
  ripgrep \
  tmux

sudo dnf install 'dnf-command(config-manager)'

# docker
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce -y
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo usermod -aG docker $USER

# github
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install -y gh

# caddy
sudo dnf install -y 'dnf-command(copr)'
sudo dnf copr enable -y @caddy/caddy
sudo dnf install -y caddy
sudo systemctl enable caddy.service
sudo systemctl start caddy.service
sudo firewall-cmd --zone=public --permanent --add-service=http
sudo firewall-cmd --zone=public --permanent --add-service=https
sudo firewall-cmd --zone=public --add-service=http
sudo firewall-cmd --zone=public --add-service=https

# starship
dnf copr enable -y atim/starship
dnf install -y starship

# helix
sudo dnf copr enable -y varlad/helix
sudo dnf install -y helix
