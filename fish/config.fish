# env
set -gx EDITOR vim
set -gx GOPATH ~/.go
set -gx TZ (readlink /etc/localtime | sed 's@/var/db/timezone/zoneinfo/@@')

set -gx DOTFILES ~/.dotfiles
set -gx NOTES ~/code/notes
set -gx PROJECTS ~/code

fish_add_path -m ~/.bin
fish_add_path -m ~/.dotfiles/bin
fish_add_path -m ~/.local/bin
if test -d "$HOME/.go/bin"
  fish_add_path -m ~/.go/bin
end
if test -d "$HOME/.cargo/bin"
  fish_add_path -m ~/.cargo/bin
end
if test -d "/usr/local/opt/llvm/bin"
  fish_add_path -m /usr/local/opt/llvm/bin
end
if test -d "$HOME/Library/Application\ Support/multipass/bin"
  fish_add_path -m ~/Library/Application\ Support/multipass/bin
end
if test -d "/Applications/IntelliJ IDEA CE.app/Contents/MacOS"
  fish_add_path -m /Applications/IntelliJ\ IDEA\ CE.app/Contents/MacOS
end
fish_add_path -m /opt/local/bin
fish_add_path -m /opt/local/sbin

# greeting
function fish_greeting
end

# starship
if command -q starship
  set -gx STARSHIP_CONFIG $DOTFILES/starship/starship.toml
  starship init fish | source
end

# zoxide
if command -q zoxide
  zoxide init fish | source
end

# direnv
if command -q direnv
  direnv hook fish | source
end

# lazygit
if command -q lazygit
  abbr --add lg 'lazygit'
end

# zk
if command -q zk
  set -gx ZK_NOTEBOOK_DIR $NOTES
end

# bat
if command -q bat
  abbr --add cat 'bat -p'
end

# lsd
if command -q lsd
  abbr --add l 'lsd --group-dirs first -A'
  abbr --add ll 'lsd --group-dirs first -Al'
  abbr --add lt 'lsd --group-dirs last -A --tree'
end
if command -q exa
  abbr --add l 'exa --icons'
  abbr --add ll 'exa -l -g --icons'
  abbr --add lt 'exa -l -g --icons --tree'
end

# cd
abbr cdc 'cd ~/code'
abbr cdd 'cd ~/Downloads'
abbr cdf 'cd ~/.dotfiles'
abbr cdh 'cd ~'
abbr cdn 'cd ~/code/notes'

function mkcd
  mkdir -p -- "$1" && cd -P -- "$1"
end

# directory
abbr --add rmr 'rm -rf'

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

# brew
abbr --add bi 'brew install'
abbr --add bic 'brew install --cask'
abbr --add bo 'brew outdated'
abbr --add bu 'brew update'

# rustup
abbr --add ru 'rustup update'

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
abbr --add vz 'vim ~/.dotfiles/zk/config.toml'
abbr --add vpc 'vim +PlugClean'
abbr --add vpi 'vim +PlugInstall'
abbr --add vpu 'vim +PlugUpdate'

# rsync
abbr --add rcp "rsync -vhra --include='**.gitignore' --exclude='/.git' --filter=':- .gitignore' --delete-after"
abbr --add rscp 'rsync --archive --compress-level=3 --copy-links --partial --inplace --progress --rsh=ssh -r'
abbr --add rcpl 'rsync --compress --verbose --human-readable --partial --progress'

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

# just
if command -q just
  abbr --add jb just build
  abbr --add jr just run
  abbr --add jt just test
end

# rust
abbr --add cb cargo build
abbr --add cr cargo run
abbr --add ct cargo test
abbr --add ch cargo check
abbr --add cl cargo clippy
abbr --add cw cargo watch -x 'run'

# zk
if command -q zk
  abbr --add zc zk snippet
  abbr --add zj zk journal
  abbr --add zs zk scratch
  abbr --add zn zk inbox
end

# multipass
if command -q multipass
  abbr --add mp multipass
end

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

# local config.
if test -f ~/.config.fish.local
  source ~/.config.fish.local
end
