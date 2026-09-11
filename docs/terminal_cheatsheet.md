# Terminal Cheatsheet

Alacritty runs **tmux**, Ghostty runs **herdr**. Both send the multiplexer
prefix (`Ctrl+\`) followed by a key for most shortcuts below, so tmux/herdr
commands can be triggered directly with `Cmd` combos instead of pressing the
prefix manually. On Linux there's no Ghostty; Alacritty runs tmux the same
way, minus the Ghostty-switch binding.

## Switch Apps

- `` Cmd+` `` - cycle between Alacritty windows (native macOS, Alacritty only)
- `Cmd+Shift+B` - switch to the other terminal app (Alacritty opens Ghostty; Ghostty opens Alacritty)
- `Cmd+Esc` - toggle Ghostty's quick terminal (global hotkey, works even when Ghostty isn't focused; Ghostty only)

## Font Size

- `Cmd+0` - reset font size
- `Cmd+=` / `Cmd++` - increase font size
- `Cmd+-` - decrease font size

## Sessions & Workspaces

- `Cmd+N` - Alacritty: switch session in current window (sessions popup) · Ghostty: new workspace
- `Cmd+Shift+N` - Alacritty: open a new OS window with the all-sessions/servers menu (across machines) · Ghostty: new workspace (same as `Cmd+N`)
- `Cmd+Shift+[` / `Cmd+Shift+]` - Ghostty only: switch to previous/next workspace

## Tabs

- `Cmd+T` - new tab with default shell
- `Cmd+Shift+T` - new tab, pick a command from the commands list
- `Cmd+[` / `Cmd+]` - previous/next tab
- `Cmd+1`..`Cmd+9` - switch to tab 1-9
- `Cmd+Shift+1`..`Cmd+Shift+9` - Alacritty: move the current pane to tab 1-9 · Ghostty: focus agent 1-9 (sidebar)
- `Cmd+Shift+W` - close tab
- `Cmd+Q` - detach from the current session (Alacritty labels this "close the window")

## Panes / Splits

- `Cmd+D` - Alacritty: split pane vertically, left/right (`%`) · Ghostty: split pane horizontally, top/bottom (`"`)
- `Cmd+Shift+D` - Alacritty: split pane horizontally, top/bottom (`"`) · Ghostty: split pane vertically, left/right (`%`)
- `Cmd+W` - close the current pane
- `Cmd+H` / `Cmd+J` / `Cmd+K` / `Cmd+L` (also arrow keys) - focus pane left/down/up/right
- `Cmd+Shift+H` / `Cmd+Shift+J` / `Cmd+Shift+K` / `Cmd+Shift+L` - resize pane left/down/up/right
- `Cmd+Alt+H` / `Cmd+Alt+J` / `Cmd+Alt+K` / `Cmd+Alt+L` - swap pane with left/down/up/right neighbor
- `Cmd+B` - jump to last active pane
- `Cmd+Return` / `Cmd+Shift+Return` - toggle pane zoom

## Find, Grep & Goto

- `Cmd+F` - enter copy mode, search forward
- `Cmd+Shift+F` - enter copy mode, search backward
- `Cmd+G` - grep files in the project, open the result in vim
- `Cmd+Shift+G` - go to a specific pane (pane picker)

## Menus & Commands

- `Cmd+R` - project menu: single-keystroke hotkey menu of build/run/test commands for the current project, output goes to the right pane
- `Cmd+Shift+R` - pick a command from the full project commands list (right pane)
- `Cmd+P` - apps menu: single-keystroke hotkey menu (Copilot/Gemini/Btop/Lazygit/Popup/Yue)
- `Cmd+Shift+P` - Alacritty: pick a command from the general commands list, opens in a new split · Ghostty: same as `Cmd+P` (apps menu)
- `Cmd+X` - Alacritty only: tmux menu (synchronize panes / rename tab / run a tmux command)
- `Cmd+Shift+X` - Alacritty only: kill all other panes in the tab

## Vim

- `Cmd+S` - save current file (`:w`)
- `Cmd+Shift+S` - save all files (`:wa`)

## Ghostty-only (native)

- `Cmd+C` / `Cmd+V` / `Cmd+Shift+V` - copy / paste / paste from selection
- `Cmd+Up` / `Cmd+Down` / `Cmd+Shift+Up` / `Cmd+Shift+Down` - jump to previous/next shell prompt
- `Cmd+PageUp` / `Cmd+PageDown` - scroll page up/down
- `Cmd+Home` / `Cmd+End` - scroll to top/bottom
- `Shift+Arrow`, `Shift+PageUp`/`PageDown`, `Shift+Home`/`End` - adjust text selection
