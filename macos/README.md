# macOS

## Host Name

```shell
sudo scutil --set LocalHostName qingshan-mba
hostname
```

## Apps in Dock and Space

5 Spaces

1. Development: Code/Editor/Terminal
2. Information: Web/Notes/Books
3. Communication: Slack/Mail
4. Productivity: Reminders/Calendar
5. Entertainment & Personal: IINA/Podcasts/iPhone

## HyperKey

- Remap physical key to hyperkey = CapsLock
- Apply hyperkey to [Click Drag Move]
- Open on login
- Hide menu bar icon

## Ghostty

Add in Login Items
```
sudo sfltool add --label "Ghostty" -a "/Applications/Ghostty.app"
defaults write com.mitchellh.ghostty TerminalDefaultLevel -int 3
```

## Shortcuts

- Hyperkey only remaps CapsLock to the ⌃⌥⌘⇧ combo; it does not bind actions.
- App-launch shortcuts are bound with `skhd` (`~/.config/skhd/skhdrc`,
  symlinked from `macos/skhdrc`; installed/started via `make skhd`).
- Grant skhd Accessibility permission once in System Settings > Privacy &
  Security > Accessibility, then restart it: `skhd --restart-service`.
- e.g. `<Hyper>+d` - launch Dictionary

## Keyboard

## Tailscale

```shell
/Applications/Tailscale.app/Contents/MacOS/Tailscale set --hostname=qingshan-mba
```
