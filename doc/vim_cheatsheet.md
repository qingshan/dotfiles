# Vim Cheatsheet

## Motions

An optional count that can be given before most of motions.

### Moving
- `j`, `k`, `l`, `h` - General move.
- `w`, `b`, `e`, `W`, `B`, `E`, `ge`, `gE` - Go forward and backward by word.
- `$`, `^`, `0` - Go to beginning and end of lines.
- `gg`, `G` - Go to beginning and end of file.
- `{count}G` - Go to specific lines.
- `(`, `)`, `}`, `{` - Go forward/backward by sentence/paragraph.
- `%` - Jump to matching ({[]}).

### Text Objects
- `iw`, `aw` - Word.
- `iW`, `aW` - WORD.
- `is`, `as` - Sentence.
- `ip`, `ap` - Paragraph.
- `it`, `at` - Tag block.
- `i)`, `a)`, `i]`, `a]`, `i}`, `a}`, `i>`, `a>` `i"`, `a"`, `i'`, `a'` - Pair text block.
---
- `i{text-object}` - Apply operator inside text-object.
- `a{text-object}` - Apply operator to all text-object including trailing whitespace.

### Finding
- `f{character}`, `F{character}`, `t{character}`, `T{character}` - Find next and previous occurrence of character.
- `;` , `,` - Go to next and previous occurrence of {character}.
---
- `/{pattern}`, `?{pattern}` - Search forward and backward for {pattern}. {pattern} is a regex.
- `/`, `?` - Repeat last search forward and backward.
- `n`, `N` - Go to next and previous match.
- `*`, `#` - Search forward and backward for word under cursor.
- `gn`, `gN` - Search forward and backward for the last used search pattern.

### Marks
- `‘{a-z}` - Move the cursor to the start of the line where the mark was set.
- `‘’` - Go back to the previous jump location.
- `‘.` - Go to the position where the last change was made.
---
- `m{a-z}` - Set mark {a-z} at cursor position.
- `m{A-Z}` - Sets a global mark and will work between files.
- `:marks` - List of marks.

## Commands

An optional count that can be given before most of commands.

### Normal Commands
- `[count]{operator}[count]{motion}`
---
- `y`, `c`, `d` - Yank and cut.
- `<`, `>`, `=` - Indent text.
- `~`, `g~`, `gu`, `gU` - Switch case.
- `=`, `!` - Filter through an external program. e.g.: `!ipsort -u`
- `gq`, `gw` - Format text

### Visual Commands
- `{Visual}[count]{motion}{operator}`
- `v`, `V`, `<Ctrl-v>` - Start Visual mode: Characterwise, Linewise, Blockwise.
---
- `r{char}` - Replace every character in selection with {char}
- `c` - Substitute (inserted text replicated on each line for blockwise)
- `J` / `gJ` - Join / join (remove whitespace)
- `p` - Put (replace selection with contents of register)
- `u`, `U` - Switch case.
- `I` - Insert (prepend, only on blockwise selection)
- `A` - Insert (append, only on blockwise selection)
---
- `gv` - Start visual mode with the previous selection.
- `O` - Move to other corner of block.
- `o` - Move to other end of marked area.

### Aliases
- `dd` = `d_` - Delete line.
- `cc` = `c_` - Change line.
- `yy` = `y_` - Yank line.
- `C` = `c$` - Change until the end of the line.
- `D` = `d$` - Delete until the end of the line.
- `Y` = `y$` - Yank until the end the line.
- `A` = `$a` - Append text to end of the line.
- `>>` = `>_` = `>l` - Indent line.
- `<<` = `<_` = `>l` - Unindent line.
- `g~~`, `guu`, `gUU` - Switch case of the line.

### Registers and Macros
`"{a-zA-Z}` - Use register for text deleted with: `d{motion}`, `D`, `dd`, `c{motion}`, `C`, `cc` or copied with: `y{motion}`, `Y`, `yy`.
`<Visual>"{a-zA-Z}` - Use register in Visual mode for text deleted with: `d`, `D`,`c`, `C` and copied with `y`, `Y`.
`"{a-zA-Z0-9.%#:-"}` - Use register for put text: `p`, `P`.
- `":` - The last commnad.
- `""` - Unnamed register: text deleted with the `d`, `c`, commands or copied with the yank `y` command.
- `"."` - The last inserted text.
- `"%` - The name of the current file.
- `"{0-9}` - The last yank.
---
- `q{a-z}` - Start a macro recording, and `q` to stop.
- `@{a-z}` - Replay the macro.
- `:@{a-z}` - Execute the contents of register {a-z} as an Ex command.
---
- `:reg` - List of registers

### Input Commands
- `i`, `I`, `a`, `A`, `o`, `O` - Start insert mode.

### Replace Commands
- `r`, `R` - Replace a single character with the specified char.

### Substitute
- `:[range]s/{pattern}/{substitute}/[flags]` - Substitute matched pattern for string literal in given range.
---
- `g flag` - Substitute all matches in a line.
- `i flag` - Case insensitive search.
- `c flag` - Confirm substitution for each match.
---
- `:{start},{end}` - Start and end lines of range e.g. :`1,2d`.
- `:{start},{offset}` - Start and offset lines of range e.g. :`1,+2d`.
- `.` - Current line e.g. :`.,+2d`.
- `%` - Whole file e.g. :`%d`.
- `0` - Beginning of file e.g. :`0,10d`.
- `1` - First line of the file e.g. :`10,$d`.
- `$` - End of file e.g. :`10,$d`.
- `'{a-z}'` - Line containing mark {a-z}
- `:'<,'>` - Visual selection.

### Ex Commands
- `:[range]sort` - Sort
- `:[range]uniq` - Uniq
- `:[range]delete [x]` - Delete specified lines [into register x]
- `:[range]yank [x]` - Yank specified lines [into register x]
- `:[line]put [x]` - Put the text from register x after the specified line
- `:[range]copy {address}` - Copy the specified lines to below the line specified by {address}
- `:[range]move {address}` - Move the specified lines to below the line specified by {address}
- `:[range]join` - Join the specified lines
- `:[range]normal {commands}` - Execute Normal mode {commands} on each specified line

### Shell commands
- `:!ls`, `:r !ls` - Execute shell commands.

### Adding and Subtracting
- `<Ctrl-a>`, `<Ctrl-x>`, `{Visual} <Ctrl-a>`, `{Visual} <Ctrl-x>`, `{Visual}g <Ctrl-a>`, `{Visual}g <Ctrl-x>` - increment/decrement number.

### Repeating
- `.` - Repeat last edit command.
- `@@` - Repeat the last macro.
- `@:` - Repeat the last ex.
- `:[range]g/{pattern}/[cmd]` - Execute Ex command on the lines within [range] where {pattern} matches.
- `:[range]g!/{pattern}/[cmd]`, `:[range]v/{pattern}/[cmd]` - Execute Ex command on the lines within [range] where {pattern} does not matches.

### Undo/Redo
- `u` - Undo.
- `<Ctrl-r>` - Redo.

## Navigation

### Jumping
- `<Ctrl-o>`, `<Ctrl-i>` - Go backwards/forward in the jump list.
- `<Ctrl-^>` - Jump to alternate file.
- `g;`, `g,` - Go backward/forwards in the change list.
- `gi` - Return to insert mode where you inserted text the last time.
- `gf` - Edit the file whose name is under or after the cursor.
- `gd`, `gD` - When the cursor is on a local variable or function, jump to its declaration.
- `K` - Lookup the keyword under the cursor.
- `[/`, `]/` - Jump to comment start and end.
- `[[`, `]]` - Jump to previous and next function.
- `[m`, `]m`, `[M`, `]M` - Jump to previous and next function.
- `{count}%` - Go to {count} percentage in the file.
- `{count}|` - Go to screen column {count} in the current line.
- `gm` - Go to half a screenwidht to the right.
- `gM` - Go to halfway the text of line.

### Scrolling
- `<Ctrl-d>`,  `<Ctrl-u>`,  `<Ctrl-b>`,  `<Ctrl-f>` - Scroll up and down full/half pages.
- `<Ctrl-e>`, `<Ctrl-y>` - Move screen down and up one line.
- `H`, `M`, `L` - Move to top/middle/bottom of screen.
- `zt`, `zz`, `zb` - top/center/bottom cursor on screen.

### Folding
- `za`, `zA` - Toggle folding.
- `zc`, `zC` - Fold under the cursor.
- `zd`, `zD` - Delete one/all fold under the cursor.
- `zE` - Eliminate all folds in the window.
- `zf`, `zF`, `:{range}fo` - Create a fold.
- `zm`, `zr`, `zM`, `zR`, `zn`, `zN`, `zo`, `zO` - Open and close fold.

## Insert Mode

### Operations
- `<Ctrl-h>` - Delete last character.
- `<Ctrl-w>` - Delete backward one word.
- `<Ctrl-u>` - Delete to beginning of line.
- `<Ctrl-o>` - Run one command.
- `<Ctrl-v>{char}` - Insert character literally.

### Registers
- `<Ctrl-r>a` - Pastes the contents of the `a` register.
- `<Ctrl-r>"` - Pastes the contents of the unnamed register.
- `<Ctrl-r>0` - Pastes the contents of the yank register.
- `<Ctrl-r>=` - Evaluates an expression and inserts the result inline.
- `<Ctrl-r>:`, `<Ctrl-r>/` - Paste expression result, last command, last search pattern.

### Suggestions
- `<Ctrl-p>`  and  `<Ctrl-n>` - Opens a list of suggestions for auto-completion.
- `<Ctrl-x> <Ctrl-f>` - Opens a list of "suggestions based on the files/directories" in the current directory.
- `<Ctrl-x> <Ctrl-o>` - Opens a list of omnifunc.
- `<Ctrl-x> <Ctrl-n>` - Opens a list of keyword.
- `<Ctrl-x> <Ctrl-l>` - Opens a list of "suggestions based on the lines" in the current file.
- `<Ctrl-x> <Ctrl-p>` - Suggest similar patterns - also repeating the same commands will continuously add the next line.
- `<Ctrl-x> <Ctrl-e>`,  `<Ctrl-x> <Ctrl-y>` - scroll screen.

## Files
- `:q`, `:q!`, `:w`, `:wq`, `:x`,`ZZ` - Saving and exiting.

### Buffers
- `:e filename`, `:enew`, `:r`  - Edit a file
- `:ls`, `:b[num]` `:bn`  `:bp`, `:bd` - List available buffers and switch current window buffer.

### Windows
- `:new`, `:vnew`, `:vs`, `:sp`, `<Ctrl-w>s`, `<Ctrl-w>v` - Split windows.
- `<Ctrl-w>h`, `<Ctrl-w>i`, `<Ctrl-w>j`, `<Ctrl-w>k`, `<Ctrl-w>w` - Switch windows.
- `<Ctrl-w>+`, `<Ctrl-w>-`, `<Ctrl-w>>`, `<Ctrl-w><`, `<Ctrl-w>|`, `<Ctrl-w>=` - Resize windows.
- `:q`, `<Ctrl-w>q` - Quit a window.

### Tabs
- `:tabnew` - Open a file in a new tab.
- `gt`, `gT`, `#gt`, `:tabn`, `:tabp` - Switch tabs.
- `<Ctrl-w>T` - Move the current split window into its own tab.
- `:tabo`, `:tabdo`, `:tabc`, `tabmove #` - Manage tabs.

## Misc

### Vimdiff
- `[c`, `]c` - Jump to previous and next diff.
- `do`, `dp` - Diff obtain and put
- `:diffupdate` - Re-scan the files for differences

### Quickfix
- `:copen`, `:cclose` - Open/close quickfix window.
- `cc #`, `:cn`, `:cp`, `:cfirst`, `:clast` - Display error.

## Obsolete
- `s` = `cl` - Change character (delete and insert). Remapping to vim-subversive.
- `S` = `cc` - Change the line. Remapping to vim-subversive and vim-surround.
- `x` = `dl` - Delete next character.
- `X` = `dh` - Delete next character.

## Help
`:h tutor`, `:h quickref`, `:h index`, `:h summary`, `:h CTRL-H`, `:h i_CTRL-H`, `:h i_<Up>`, `:h pattern.txt`, `:h eval`, `:h function-list`, `:h windows.txt`, `:h tabpage.txt`, `:h +timers`, `:h :!`, `:h tips`, `:h set-termcap`, `:viusage NORMAL`, `:exusage`, `:version`

## Plugins

[Vim Plugins](vim_plugins.md)
