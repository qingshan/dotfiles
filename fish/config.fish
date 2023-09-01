# env
set -Ux EDITOR vim
set -Ux GOPATH ~/.go
set -Ux TZ (readlink /etc/localtime | sed 's@/var/db/timezone/zoneinfo/@@')

set -Ux DOTFILES ~/.dotfiles
set -Ux PROJECTS ~/code

fish_add_path -m ~/.bin
fish_add_path -m ~/.dotfiles/bin
fish_add_path -m ~/.local/bin
if test -d "$HOME/.go/bin"
  fish_add_path -m ~/.go/bin
end
if test -d "$HOME/.cargo/bin"
  fish_add_path -m ~/.cargo/bin
end
if test -d "$HOME/Library/Application\ Support/multipass/bin"
  fish_add_path -m ~/Library/Application\ Support/multipass/bin
end
if test -d "/Applications/IntelliJ IDEA CE.app/Contents/MacOS"
  fish_add_path -m /Applications/IntelliJ\ IDEA\ CE.app/Contents/MacOS
end
fish_add_path -m /opt/local/bin
fish_add_path -m /opt/local/sbin

# zoxide
zoxide init fish | source

# direnv
direnv hook fish | source

# greeting
function fish_greeting
end

function mkcd
  mkdir -p -- "$1" && cd -P -- "$1"
end

# theme
set -g theme_nerd_fonts yes
set -g theme_color_scheme gruvbox
set -g theme_date_format "+%H:%M:%S"
set -g theme_display_git no

# git
abbr --add g 'git'
abbr --add gbr 'git branch'
abbr --add gcm 'git commit -m'
abbr --add gca 'git commit --amend -m'
abbr --add gco 'git checkout'
abbr --add gd 'git diff -w'
abbr --add gds 'git diff -w --staged'
abbr --add gp 'git push origin'
abbr --add gs 'git status'
abbr --add glf 'git logf'
abbr --add glo 'git logo'
abbr --add gl 'git pull'
abbr --add gp 'git push'

# lazygit
if command -sq lazygit
  abbr --add lg 'lazygit'
end

# bat
if command -sq bat
  abbr --add cat 'bat -p'
end

# lsd
if command -sq lsd
  abbr --add l 'lsd --group-dirs first -A'
  abbr --add ll 'lsd --group-dirs first -Al'
  abbr --add lt 'lsd --group-dirs last -A --tree'
end
if command -sq exa
  abbr --add l 'exa --icons'
  abbr --add ll 'exa -l -g --icons'
  abbr --add lt 'exa -l -g --icons --tree'
end
abbr --add rmr 'rm -rf'

# cd
abbr cdd 'cd ~/Downloads'
abbr cdh 'cd ~'

# brew
abbr --add bi 'brew install'
abbr --add bic 'brew install --cask'
abbr --add bo 'brew outdated'
abbr --add bu 'brew update'

# config
abbr --add sf 'source ~/.config/fish/config.fish'
abbr --add st 'tmux source ~/.tmux.conf'

# vim
abbr --add v 'vim (fd --type f --hidden --follow --exclude .git | fzf-tmux -p --reverse)'
abbr --add va 'vim ~/.config/alacritty/alacritty.yml'
abbr --add vb 'vim ~/.dotfiles/macos/Brewfile'
abbr --add vf 'vim ~/.config/fish/config.fish'
abbr --add vh 'vim ~/.dotfiles/helix/config.toml'
abbr --add vs 'vim ~/.ssh/config'
abbr --add vt 'vim ~/.dotfiles/.tmux.conf'
abbr --add vv 'vim ~/.dotfiles/.vimrc'
abbr --add vpc 'vim +PlugClean'
abbr --add vpi 'vim +PlugInstall'
abbr --add vpu 'vim +PlugUpdate'

# rsync
abbr --add rcp "rsync -vhra --include='**.gitignore' --exclude='/.git' --filter=':- .gitignore' --delete-after"
abbr --add rscp 'rsync --archive --compress-level=3 --copy-links --partial --inplace --progress --rsh=ssh -r'

# yt-dlp
abbr --add ytdl 'yt-dlp --write-auto-sub --sub-lang en --convert-subs=srt'

# tmux sessions
abbr --add tsa 'tmux-sessions algorithms'
abbr --add tsd 'tmux-sessions dotfiles'
abbr --add tsm 'tmux-sessions main'
abbr --add tsn 'tmux-sessions notes'

# ssh
abbr --add lab 'ssh lab'
abbr --add homelab 'ssh homelab'

# make
abbr --add mb make build
abbr --add mr make run
abbr --add mt make test

# rust
abbr --add cb cargo build
abbr --add cr cargo run
abbr --add ct cargo test
abbr --add ch cargo check
abbr --add cl cargo clippy
abbr --add cw cargo watch -x 'run'

# multipass
abbr --add mp multipass

# aliases
alias ql='qlmanage -p 2>/dev/null'
alias sucs='sort | uniq -c | sort -n'
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias gcurl='grpcurl -plaintext localhost:3000'

# fzf
if command -v fzf &> /dev/null
  set -gx FZF_DEFAULT_OPTS "--layout=reverse --inline-info --height '80%' --select-1 --exit-0"
  if command -v bat &> /dev/null
    set -gx FZF_PREVIEW_FILE '--ansi --preview-window "right:60%" --preview "bat --color=always --style=header,grid "'
  end
  if command -v fd &> /dev/null
    set -gx  FZF_DEFAULT_COMMAND "fd --hidden --follow --exclude .git --type f"
  end
end

function p
  cd ~/code/$argv[1]
  hx .
end

# local config.
if [ -f ~/.config.fish.local ]
  source ~/.config.fish.local
end
