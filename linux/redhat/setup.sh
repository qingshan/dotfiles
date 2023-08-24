#!/usr/bin/sh

sudo dnf update -y
sudo dnf install epel-release -y
sudo dnf install cmake gcc make curl clang -y
sudo dnf install git
sudo dnf install vim
sudo dnf install zsh
sudo dnf install ripgrep

sudo dnf install 'dnf-command(config-manager)'

# docker
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce -y
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo usermod -aG docker $USER

# github
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh

# caddy
sudo dnf install 'dnf-command(copr)'
sudo dnf copr enable @caddy/caddy
sudo dnf install caddy
sudo systemctl enable caddy.service
sudo systemctl start caddy.service
sudo firewall-cmd --zone=public --permanent --add-service=http
sudo firewall-cmd --zone=public --permanent --add-service=https
sudo firewall-cmd --zone=public --add-service=http
sudo firewall-cmd --zone=public --add-service=https

# helix
sudo dnf copr enable varlad/helix
sudo dnf install helix
