-- Override of ~/.config/hypr/input.lua (see manual/34-keyboard-mouse-trackpad.md)
--
-- CapsLock becomes a genuine Hyper modifier (XKB Mod3), matching the same
-- HyperKey setup used on macOS (see macos/README.md) and the old Regolith
-- `.Xmodmap` (`clear lock; keycode 66 = Hyper_L; add mod3 = Hyper_L`).
-- Physical Cmd/Super is left unbound so apps (browser, Ghostty, Alacritty)
-- receive it. Omarchy/WM shortcuts are on Hyper (MOD3) in bindings.lua.
--
-- Trade-off: this replaces Omarchy's default CapsLock-as-compose-key
-- behavior, so the quick emoji/name/email completions in
-- manual/07-hotkeys.md ("Quick Emojis"/"Quick Completions") won't fire from
-- CapsLock anymore.
hl.config({
  input = {
    kb_options = "caps:hyper",
  },
})
