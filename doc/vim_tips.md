# Vim Tips

## Search & Replace

Search or replace current expression on search register `@/`, `/` or `s//{replacement}/g`
Open command window from normal mode `q:` or `q/`
Repeat last Ex command `@:`
Repeat last executed command `@@`
Repeat last substitution with Ex command `:{range}&&`
Repeat last substitution in normal and visual mode `&`

### Operate on Next Search Match

- `{operator}gn`  Apply operator on next match
---
- `.`  After using {op}gn, the dot commant repeats the last change on the next match. Woooot!
---
- `cgn` - change the next search match
- `3cgn` - change the third search match
- `cgN` - change the previous search match

### Misc
- `xp` - swap characters.
- `<Ctrl-r>=system('ls')<enter>` - The output of the ls command will be pasted in your buffer.
- `:vimgrep /pattern/ filename`  - search for pattern in multiple files

## Rename Current File

`:Gmove` - From the plugin fugitive.vim
https://stackoverflow.com/a/13501814
