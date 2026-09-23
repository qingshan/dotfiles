#!/usr/bin/sh

echo "Install tools"
sudo dnf update -y
sudo dnf install -y epel-release
sudo dnf install -y make \
  curl \
  wget \
  git \
  vim

sudo dnf install 'dnf-command(config-manager)'

# docker
echo "Install docker"
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce -y
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo usermod -aG docker $USER

# fish
echo "Install fish"
FISH_VERSION=$(curl -s "https://api.github.com/repos/fish-shell/fish-shell/releases/latest" | grep -Po '"tag_name": "\K[0-9.]+')
curl -sL "https://github.com/fish-shell/fish-shell/releases/latest/download/fish-$FISH_VERSION-linux-x86_64.tar.xz" | sudo tar -xJ -C /usr/local/bin

# mise (manages node, python, go, and various CLI tools:
# fzf, ripgrep, fd, zoxide, tmux, gh, starship, rust, just, uv, etc.)
echo "Install mise"
curl -fsSL https://mise.run | sh
