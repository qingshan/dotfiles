# env
set -gx EDITOR vim
set -gx GOPATH ~/.go
set -gx TZ (readlink /etc/localtime | sed 's@/var/db/timezone/zoneinfo/@@')
set -gx LANG 'en_US.UTF-8'

set -gx DOTFILES ~/.dotfiles
set -gx NOTES ~/code/notes
set -gx PROJECTS ~/code

# homebrew shell environment (macOS only)
if command -q brew
  brew shellenv | source
  # version agnostic python links
  fish_add_path -m (brew --prefix python)/libexec/bin
end

fish_add_path -m ~/.bin
fish_add_path -m ~/.dotfiles/bin
fish_add_path -m ~/.local/bin
if test -d ~/.go/bin
  fish_add_path -m ~/.go/bin
end
if test -d ~/.cargo/bin
  fish_add_path -m ~/.cargo/bin
end

# greeting
set -U fish_greeting

# docker
set -gx DOCKER (if command -q container; echo "container"; else; echo "docker"; end)

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

# fzf
if command -q fzf
  fzf --fish | source
end

# zk
if command -q zk
  set -gx ZK_NOTEBOOK_DIR $NOTES
end

# bat
if command -q bat
  alias cat 'bat --style=plain --paging=never'
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

# Use GNU find, grep, sed, sort, and xargs if on a Mac
if test (uname) = "Darwin"
    if command -q gfind &>/dev/null
        alias find=gfind
    end
    if command -q gsed &>/dev/null
        alias xsed=gsed
    end
    if command -q gsort &>/dev/null
        alias sort=gsort
    end
    if command -q gxargs &>/dev/null
        alias xargs=gxargs
    end
end

# cd
abbr --add cdc 'cd ~/code'
abbr --add cdw 'cd ~/work'
abbr --add cdd 'cd ~/Downloads'
abbr --add cdp 'cd ~/Public'
abbr --add cdf 'cd ~/.dotfiles'
abbr --add cdh 'cd ~'
abbr --add cdn 'cd ~/code/notes'

function mkcd
  mkdir -p -- "$argv[1]" && cd -P -- "$argv[1]"
end

# directory
abbr --add rmr 'rm -rf'

# git
abbr --add g 'git'
abbr --add ga 'git add'
abbr --add gaa 'git add -A'
abbr --add gb 'git branch'
abbr --add gbc 'git branch --show-current'
abbr --add gbd 'git branch -d'
abbr --add gbD 'git branch -D'
abbr --add gc 'git commit'
abbr --add gcm 'git commit -m'
abbr --add gca 'git commit --amend -m'
abbr --add gco 'git checkout'
abbr --add gcb 'git checkout -b'
abbr --add gd 'git diff -w'
abbr --add gds 'git diff -w --staged'
abbr --add gs 'git status'
abbr --add gpu 'git push -u'
abbr --add gpd 'git push -d origin'
abbr --add gf 'git pull'

# pr
abbr --add prl 'gh pr list'
abbr --add prv 'gh pr view --web'
abbr --add pra 'gh pr review --approve --body "LGTM"'

# brew
abbr --add bi 'brew install'
abbr --add bic 'brew install --cask'
abbr --add bo 'brew outdated'
abbr --add bog 'brew outdated --greedy --verbose'
abbr --add bu 'brew upgrade'

# rustup
abbr --add ru 'rustup update'
abbr --add rc 'rustup check'

# config
abbr --add sf 'source ~/.config/fish/config.fish'
abbr --add st 'tmux source ~/.tmux.conf'

# vim
abbr --add v 'vim (fd --type f --hidden --follow --exclude .git | fzf-tmux -p --reverse)'
abbr --add va 'vim ~/.config/alacritty/alacritty.toml'
abbr --add vb 'vim ~/.dotfiles/macos/Brewfile'
abbr --add vf 'vim ~/.config/fish/config.fish'
abbr --add vg 'vim ~/.config/ghostty/config'
abbr --add vh 'vim ~/.dotfiles/helix/config.toml'
abbr --add vs 'vim ~/.ssh/config'
abbr --add vt 'vim ~/.dotfiles/.tmux.conf'
abbr --add vv 'vim ~/.dotfiles/.vimrc'
abbr --add vz 'vim ~/.dotfiles/zk/config.toml'
abbr --add vpc 'vim +PlugClean'
abbr --add vpi 'vim +PlugInstall'
abbr --add vpu 'vim +PlugUpdate'

# ssh
abbr --add sci 'ssh-copy-id'

# rsync
abbr --add rcp 'rsync -vhra --include="**.gitignore" --exclude="/.git" --filter=":- .gitignore" --delete-after'
abbr --add rscp 'rsync --archive --compress-level=3 --copy-links --partial --inplace --progress --rsh=ssh -r'
abbr --add rcpl 'rsync --compress --verbose --human-readable --partial --progress'

# yt-dlp
abbr --add ytdl 'yt-dlp --write-auto-sub --sub-lang en --convert-subs=srt'

# tmux sessions
abbr --add tsa 'tmux-sessions algorithms'
abbr --add tsd 'tmux-sessions dotfiles'
abbr --add tsm 'tmux-sessions main'
abbr --add tsn 'tmux-sessions notes'

# make
abbr --add mb 'make build'
abbr --add mr 'make run'
abbr --add mt 'make test'
abbr --add mc 'make clean'

# just
if command -q just
  abbr --add jb 'just build'
  abbr --add jr 'just run'
  abbr --add jt 'just test'
end

# rust
abbr --add ca 'cargo add'
abbr --add cb 'cargo build'
abbr --add cba 'cargo build --all-targets'
abbr --add cbe 'cargo build --example'
abbr --add cbr 'cargo build --release'
abbr --add cr 'cargo run'
abbr --add cre 'cargo run --example'
abbr --add crr 'cargo run --release'
abbr --add ct 'cargo test'
abbr --add cta 'cargo test --all-targets'
abbr --add ctt 'cargo test --test'
abbr --add ch 'cargo check'
abbr --add ci 'cargo install'
abbr --add cl 'cargo clippy'
abbr --add cs 'cargo search'
abbr --add cw 'cargo watch -x "run"'
abbr --add cdoc 'cargo doc'

# Docker
abbr --add dc 'docker container'
abbr --add dce 'docker container exec -i -t'
abbr --add dcr 'docker container run'
abbr --add dcrn 'docker container run -i -t --name'
abbr --add dcri 'docker container run -i -t --rm'
abbr --add dcrm 'docker container rm -f'
abbr --add dcpr 'docker container prune'

abbr --add di 'docker image'
abbr --add dils 'docker image ls'
abbr --add dipr 'docker image prune'
abbr --add dcps 'docker container ps'
abbr --add dirm 'docker image rm'
abbr --add dit 'docker image tag'

abbr --add dce 'docker exec'
abbr --add deit 'docker exec -it'
abbr --add dka 'docker kill (docker ps -q)'
abbr --add dil 'docker image list'
abbr --add dip 'docker image prune'
abbr --add dipa 'docker image prune -a'

# Docker Compose
abbr --add dcd 'docker compose down'
abbr --add dck 'docker compose kill'
abbr --add dcl 'docker compose logs'
abbr --add dclf 'docker compose logs -f'
abbr --add dclft 'docker compose logs -f --tail'
abbr --add dclt 'docker compose logs --tail'
abbr --add dcS 'docker compose stop'
abbr --add dcs 'docker compose start'
abbr --add dcu 'docker compose up'
abbr --add dcud 'docker compose up -d'
abbr --add dcuf 'docker compose up -f'

# zk
if command -q zk
  abbr --add zc 'zk snippet'
  abbr --add zj 'zk journal'
  abbr --add zs 'zk scratch'
  abbr --add zn 'zk inbox'
end

function devbox
  set action $argv[1]
  if test "$action" = "create"
    $DOCKER build -t devbox -f ~/.dotfiles/linux/debian/Dockerfile .
  else if test "$action" = "ssh"
    ssh devbox
  else
    $DOCKER $argv[1] devbox $argv[2..]
  end
end

# ports
function ports
  if set -q argv[1]
    set PORT $argv[1]
    sudo lsof -iTCP:$PORT -sTCP:LISTEN -n -P
  else
    sudo lsof -iTCP -sTCP:LISTEN -n -P
  end
end

# aliases
alias d="$DOCKER"
alias e="$EDITOR"
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ql='qlmanage -p 2>/dev/null'
alias sucs='sort | uniq -c | sort -n'

# fzf
if command -v fzf &> /dev/null
  set -gx FZF_DEFAULT_OPTS '--layout=reverse --inline-info --height "80%" --select-1 --exit-0'
  if command -v bat &> /dev/null
    set -gx FZF_PREVIEW_FILE '--ansi --preview-window "right:60%" --preview "bat --color=always --style=header,grid "'
  end
  if command -v fd &> /dev/null
    set -gx  FZF_DEFAULT_COMMAND 'fd --hidden --follow --exclude .git --type f'
  end
end

# local config.
if test -f ~/.config.fish.local
  source ~/.config.fish.local
end
