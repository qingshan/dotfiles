# Desktop Cheatsheet

Cross-platform shortcuts bound to the Hyper key (CapsLock) on both
[macOS](../macos/README.md) (HyperKey) and [Omarchy](../omarchy/README.md)
(`caps:hyper` in `hypr/input.lua`, bindings in `hypr/bindings.lua`).
Physical Super/Cmd is left for apps (browser, Ghostty, Alacritty).

## Focus Window

- `<Hyper>+h` - focus left
- `<Hyper>+j` - focus down
- `<Hyper>+k` - focus up
- `<Hyper>+l` - focus right

## Move Window

- `<Hyper>+Shift+h` - move left
- `<Hyper>+Shift+j` - move down
- `<Hyper>+Shift+k` - move up
- `<Hyper>+Shift+l` - move right

## Toggle Window

- `<Hyper>+f` - fullscreen toggle
- `<Hyper>+Shift+f` - floating toggle
- `<Hyper>+minus` - scratchpad show
- `<Hyper>+Shift+minus` - move scratchpad

## Workspace

- `<Hyper>+#` - switch workspace #
- `<Hyper>+Shift+#` - move container to workspace #; workspace #

## Management

- `<Hyper>+Tab` - window switcher
- `<Hyper>+Shift+q` - kill current application

- `<Hyper>+Space` - Omarchy menu
- `<Hyper>+Shift+Space` - hide/show bar
- `<Hyper>+Escape` - system menu (logout/reboot/power)
- `<Hyper>+Ctrl+L` - lock
- reload config -> automatic on save

## Launch

- `<Hyper>+Return` - exec terminal
- `<Hyper>+Shift+Return` - exec browser
- `<Hyper>+T` - Alacritty
- `<Hyper>+G` - Ghostty
- `<Hyper>+E` - Zed
- `<Hyper>+I` (Omarchy) / `<Hyper>+J` (macOS) - IntelliJ IDEA
- `<Hyper>+W` - Chrome
- `<Hyper>+B` - Brave
- `<Hyper>+O` - Obsidian
- `<Hyper>+S` - Slack
- `<Hyper>+Z` - Zoom
- `<Hyper>+V` - mpv (Omarchy) / IINA (macOS)

macOS-only (no Linux app installed): `<Hyper>+D` Dictionary, `+N` Notes,
`+M` Mail, `+R` Reminders, `+C` Calendar, `+P` Podcasts. See
[macos/skhdrc](../macos/skhdrc) and
[omarchy/hypr/bindings.lua](../omarchy/hypr/bindings.lua).

Screenshots use bare `Print Screen` under Omarchy (no modifier needed) —
see `docs/terminal_cheatsheet.md`.
