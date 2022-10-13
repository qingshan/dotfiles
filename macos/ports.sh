sudo port selfupdate
sudo port install python310
sudo port install py310-pip
sudo port install fish
sudo port install tmux
sudo port install fzf
sudo port install ripgrep
sudo port install vim +python310
sudo port install git
sudo port install zoxide
sudo port install zola
sudo port install rust-analyzer
sudo port install autossh
sudo port install gh
sudo port install git-delta
sudo port install git-lfs
sudo port install htop
sudo port install xsv
sudo port install jq
sudo port install miller
sudo port install direnv
sudo port install htop
sudo port install parallel
sudo port install lazygit
sudo port install fd
sudo port install sd
sudo port install lsd
sudo port install alacritty
git clone --filter=blob:none --sparse http://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
git sparse-checkout add patched-fonts/JetBrainsMono
./install.sh JetBrainsMono
cd .dotfiles/macos
curl -Ls https://raw.githubusercontent.com/kevinSuttle/macOS-Defaults/master/.macos | sh
curl -Ls https://raw.githubusercontent.com/daipeihust/im-select/master/install_mac.sh | sh
sudo port select --set python python310
sudo port select --set python3 python310
sudo port select --set pip pip310
sudo port select --set pip3 pip310
