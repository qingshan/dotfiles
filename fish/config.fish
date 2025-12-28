# greeting
set -U fish_greeting

# env
set -gx DOTFILES_PATH ~/.dotfiles
set -gx NOTES_PATH ~/.notes
set -gx PROJECTS_PATH ~/Projects
set -gx BOOKS_PATH ~/Public/Books
set -gx MOVIES_PATH ~/Public/Movies

# docker
set -gx DOCKER (if command -q container; echo "container"; else; echo "docker"; end)

# starship
if command -q starship
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

# bat
if command -q bat
  alias cat 'bat --style=plain --paging=never'
end

# lsd
if command -q lsd
  alias ll='lsd --group-dirs first -Al'
  alias lt='lsd --group-dirs last -A --tree'
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

# pdsh
if command -q pdsh
  set -gx PDSH_RCMD_TYPE ssh
end

# aliases
alias d="$DOCKER"
alias e="$EDITOR"
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ql='qlmanage -p 2>/dev/null'
alias sucs='sort | uniq -c | sort -n'

# apps
if not command -q tailscale; test -d /Applications/Tailscale.app
  alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
  tailscale completion fish | source
end

if not command -q ghostty; test -d /Applications/Ghostty.app
  alias ghostty="/Applications/Ghostty.app/Contents/MacOS/ghostty"
  alias launcher='open -na Ghostty --args --title=Launcher --class=Launcher --initial-window=true --quit-after-last-window-closed=true  --window-padding-x=10 --window-padding-y=10 --keybind=clear'
end

# rsync
alias rcp='rsync -vhra --include="**.gitignore" --exclude="/.git" --filter=":- .gitignore" --delete-after'
alias rscp='rsync --archive --compress-level=3 --copy-links --partial --inplace --progress --rsh=ssh -r'
alias rcpl='rsync --compress --verbose --human-readable --partial --progress'

# yt-dlp
alias ytdl='yt-dlp --write-auto-sub --sub-lang en --convert-subs=srt'

# cd
abbr --add cdc 'cd ~/code'
abbr --add cdw 'cd ~/work'
abbr --add cdd 'cd ~/Downloads'
abbr --add cdp 'cd ~/Public'
abbr --add cdf 'cd ~/.dotfiles'
abbr --add cdh 'cd ~'
abbr --add cdn 'cd ~/code/notes'

# directory
abbr --add rmr 'rm -rf'

# find file
abbr --add ff 'find . -name'

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

# git worktree
abbr --add gwt "git worktree"
abbr --add gwta "git worktree add"
abbr --add gwtls "git worktree list"
abbr --add gwtmv "git worktree move"
abbr --add gwtrm "git worktree remove"

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
abbr --add vpc 'vim +PlugClean'
abbr --add vpi 'vim +PlugInstall'
abbr --add vpu 'vim +PlugUpdate'

# ssh
abbr --add sci 'ssh-copy-id'

function rssh -a server
  echo "$argv[2..]" | ssh $server
end

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

# make directory and cd
function mkcd -a path
  mkdir -p "$path" && cd "$path"
end

# devbox
function devbox -a action
  if test "$action" = "create"
    $DOCKER build -t devbox -f ~/.dotfiles/linux/debian/Dockerfile .
  else if test "$action" = "ssh"
    ssh devbox
  else
    $DOCKER $action devbox $argv[2..]
  end
end

# ports
function ports -a port
  if set -q port
    sudo lsof -iTCP:$port -sTCP:LISTEN -n -P
  else
    sudo lsof -iTCP -sTCP:LISTEN -n -P
  end
end

# fzf
if command -v fzf &> /dev/null
  set -gx FZF_DEFAULT_OPTS '--layout=reverse --info=inline-right --height "80%" --select-1 --exit-0'
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
