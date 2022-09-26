# env
set -Ux EDITOR vim
set -Ux TZ (readlink /etc/localtime | sed 's@/var/db/timezone/zoneinfo/@@')

set -Ux DOTFILES ~/.dotfiles
set -Ux PROJECTS ~/Developer

# path
fish_add_path -m ~/.bin
fish_add_path -m ~/.local/bin
fish_add_path -m ~/go/bin
fish_add_path -m ~/.cargo/bin

# zoxide
zoxide init fish | source

# greeting
function fish_greeting
end

function ide
  tmux split-window -v -p 30
  tmux split-window -h -p 50
end

# theme
set -g theme_nerd_fonts yes
set -g theme_color_scheme gruvbox
set -g theme_date_format "+%H:%M:%S"

# abbr
abbr --add e "exit"

# git
abbr --add g 'git'
abbr --add ga 'git amend'
abbr --add gbr 'git br'
abbr --add gco 'git co'
abbr --add gd 'git diff -w'
abbr --add gds 'git diff -w --staged'
abbr --add gp 'git push origin'
abbr --add gs 'git status'
abbr --add glf 'git logf'
abbr --add glo 'git logo'
abbr --add gl "git pull"
abbr --add gp "git push"
abbr --add lg "lazygit"

# lsd
if command -sq lsd
  abbr --add l "lsd --group-dirs first -A"
  abbr --add ll "lsd --group-dirs first -Al"
  abbr --add lt "lsd --group-dirs last -A --tree"
end
abbr --add rmr "rm -rf"

# brew
abbr --add bi "brew install"
abbr --add bic "brew install --cask"
abbr --add bo "brew outdated"
abbr --add bu "brew update"

# config
abbr --add sf "source ~/.config/fish/config.fish"
abbr --add st "tmux source ~/.tmux.conf"

# vim
abbr --add v "vim (fd --type f --hidden --follow --exclude .git | fzf-tmux -p --reverse)"
abbr --add va "vim ~/.config/alacritty/alacritty.yml"
abbr --add vf "vim ~/.config/fish/config.fish"
abbr --add vpc "nvim +PlugClean"
abbr --add vpi "nvim +PlugInstall"
abbr --add vpu "nvim +PlugUpdate"

# rsync
abbr --add rcp "rsync -vhra --include='**.gitignore' --exclude='/.git' --filter=':- .gitignore' --delete-after"

# cloudian-tunnel
abbr --add ctc "cloudian-tunnel.app connect"

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
if [ -f ~/.config.fish ]
  source ~/.config.fish
end
