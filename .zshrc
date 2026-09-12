# Use Fish for interactive terminals; keep explicit commands and child shells.
if [[ $- == *i* && -z ${ZSH_EXECUTION_STRING} ]] && command -v fish >/dev/null 2>&1; then
    dotfiles_parent_shell=$(ps -p "$PPID" -o comm= 2>/dev/null)
    dotfiles_parent_shell=${dotfiles_parent_shell##*/}
    if [[ $dotfiles_parent_shell != *fish ]]; then
        if [[ -o login ]]; then
            exec fish --login
        else
            exec fish
        fi
    fi
    unset dotfiles_parent_shell
fi
