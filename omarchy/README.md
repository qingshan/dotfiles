# Omarchy

## Version

Omarchy Quattro (v4), an Arch Linux + Hyprland desktop by DHH. See
[omarchy.org](https://omarchy.org) and the
[manual](https://github.com/omacom/omarchy/tree/quattro/manual).

## Desktop

Replaces the earlier Manjaro (`linux/arch`, i3 + rofi + conky) and Debian
Regolith (`debian/`, i3 + xremap + xmodmap) setups, both retired in favor of
Omarchy.

## What's managed here

Omarchy is configured through overrides in `~/.config/hypr/*.lua`, layered
on top of its own defaults in `/usr/share/omarchy` (never edit those
directly — they're overwritten on update). `omarchy/setup.sh` symlinks:

- `hypr/input.lua` — remaps CapsLock to a genuine Hyper key (`caps:hyper`,
  XKB Mod3), matching the HyperKey setup on [macOS](../macos/README.md).
- `hypr/bindings.lua` — window-manager shortcuts from
  [Desktop Cheatsheet](../docs/desktop_cheatsheet.md) on Hyper (MOD3).
  Omarchy's native `SUPER + ...` defaults are disabled so Super/Cmd
  reaches the browser, Ghostty, and Alacritty.

## Setup

Run `make desktop` (invoked automatically from `make install` via
`desktop-linux` when the `omarchy` command is detected on `$PATH`).
