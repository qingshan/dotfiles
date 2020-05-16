# Arch Linux

## Update

```
sudo pacman-mirrors --country United_States
sudo pacman -Syyu
```

## Install

```
make archlinux
```

## Dotfiles
git clone https://github.com/qingshan/dotfiles.git ~/.dotfiles
make dotfiles
sh shell.sh 
sh powerline.sh 
sh vim.sh 
vi ~/.zshrc.local 
vi ~/.tmux.conf.local 

## Pulse Audio
/etc/pulse/default.pa

```
# automatically switch to newly-connected devices
load-module module-switch-on-connect
```

/etc/bluetooth/main.conf
```
[Policy]
AutoEnable=true
```

## Packages

[Virtualbox](https://wiki.manjaro.org/index.php?title=VirtualBox)

[Windows VM](https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/)
[Generic Windows](https://fishilico.github.io/generic-config/windows/vagrant.html)
