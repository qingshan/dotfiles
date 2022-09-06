#!/usr/bin/sh

sudo apt update
sudo apt install zsh
sudo apt install python3-pip
sudo apt install fzf
sudo apt install ripgrep

# caddy
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
sudo mkdir -p /etc/apt/keyrings
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install -y caddy
sudo systemctl enable caddy.service
sudo systemctl start caddy.service

# docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo usermod -aG docker $USER

# gh
sudo apt install gh -y

# zola
ZOLA_VERSION=0.16.0
curl -sL https://github.com/getzola/zola/releases/download/v${ZOLA_VERSION}/zola-v${ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz | sudo tar xz -C /usr/local/bin

# mdbook
MDBOOK_VERSION=0.4.21
curl -sL https://github.com/rust-lang/mdBook/releases/download/v${MDBOOK_VERSION}/mdbook-v${MDBOOK_VERSION}-x86_64-unknown-linux-gnu.tar.gz | sudo tar xz -C /usr/local/bin

# TODO
# iptables: http/https
# gh auth login
