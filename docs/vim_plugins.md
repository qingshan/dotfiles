# Vim Plugins

## Prefixes

- `<Space>` - Leader
- `\` - Local Leader
- `:` - Command

## Color Scheme

`gruvbox` - Color scheme.

## Text Objects

- `i,`, `a,`, `ia`, `aa` - An argument in a list of arguments surrounded by braces and commas. (provided by vim-swap)
- `il`, `al` - The current line (provided by vim-textobj-line).
- `ie`, `ae` - The entire content of the current buffer (provided by vim-textobj-entire).
- `i%`, `a%` - Any block text objects (provided by match-up)
- `ii`, `ai`, `iI`, `aI` - An Indentation level and line above/below (provided by vim-indent-object)
- `ib`, `ab`, `is`, `as` - Search and select a sandwiched text automatically or with query (provided by vim-sandwich)

Go
---
- `if`, `af` - Function text objects (provided by vim-go)
- `ic`, `ac` - Comment text objects (provided by vim-go)

## Shortcuts

- `<Ctrl-j>`, `<Ctrl-k>` - Move lines in normal and visual mode.
- `<Leader>y`, `<Leader>Y`, `<Leader>p`, `<Leader>P` - Copy to and paste from system clipboard.
- `<Leader>w` - Fast saving.
- `<Leader>o` - Close all other windows but the current window.
- `<Leader>O` - Close all other tabs but the current tab.
- `<Leader>q` - Quit the current window.
- `<Leader>Q` - Close the current tab.
- `<Leader>x` - Close the quickfix window.
- `:CC` - Toggle color column.
- `:CD` - Change directory of the current file.

Tabs

---
- `<Leader>#` - Switch tab by #.

Terminal

---
- `:T` - Open terminal in current window
- `:TT` - Open terminal in new tab
- `:TS` - Open terminal in horizontal
- `:TV` - Open terminal in vertical

## Plugins

### vim-matchup

- `%`, `g%`, `[%', ']%`, `z%` - Better `%` motions.

### splitjoin.vim

- `gS` - to split a one-liner into multiple lines
- `gJ` - (with the cursor on the first line of a block) to join a block into a single-line statement.

### vim-swap (:help swap.txt)

- `g<`, `g>` - swaps the item under the cursor with the former/latter item.
- `gs` - works more interactive. It starts "swap mode". In the mode, use `h`/`l` to swap items, `j`/`k` to choose item, numbers `1` ~ `9` to select `n`th item, `u`/`<C-r>` to undo/redo, and as you know `<Esc>` to exit "swap mode". In |linewise-visual| and |blockwise-visual| mode, this plugin always swaps in each line.

### vim-expand-region

- `+`, `_` - Expand and shrink the visual selection.

### vim-sensible

- `<Ctrl-l>` - Clear highlighted text in normal mode

### vim-sandwich

- `sa{motion}{surround_char}` - Add surrounding, e.g.: `saiw(`
- `sd{surround_char}` - Delete surrounding, e.g.: `dst`
- `sr{target_char}{surround_char}` - Change surrounding, , e.g.: `sr'"`
- `sdb`, `srb` - Searchs a set of surrounding automatically.
- `<LocalLeader>s`, `<LocalLeader>S` - Quick surround word or WORD.

### vim-abolish

- `crm` - Convert to MixedCase
- `crc` - Convert to camelCase
- `crs` - Convert to snake_case
- `cru` - Convert to UPPER_CASE
- `cr-`, `cr.`, `cr<Space>`, `crt` - dash-case (`cr-`), dot.case (`cr.`), space case (`cr<Space>`), and Title Case (`crt`).
- `:S/p1/p2/g` - Preserve case substitute

### vim-easy-align

- `ga{motion}` - Easy align in normal mode.
- `ga` - Easy align in visual mode.

### vim-ReplaceWithRegister

- `gr{motion}` - Replace {motion} text with the contents of the unnamed register.
- `grr` - Replace line with the contents of the unnamed register.
- `{Visual}gr` - Replace the selection with the contents of the unnamed register.

### vim-commentary

- `gc{motion}` comment out the target of a motion
- `gcc` - comment out a line (takes a count)
- `gc` - in visual mode to comment out the selection,
- `Commentary` use it as a command, either with a range like `:7,17Commentary`, or as part of a :global invocation like with `:g/TODO/Commentary`.

### vim-unimpaired

- `[b`, `]b`, `[B`, `]B` Buffers(bp, bn, bfirst, blast)
- `[q`, `]q`, `[Q`, `]Q` Quickfix
- `[u`, `]u`, `[x`, `]x`, `[y`, `]y` - url/xml/cstring encode and decode
- `[<Space>`, `]<Space>` - new line above/below
- `[e`, `]e` - exchange line above/below
- `[c`, `]c` - Quick jumping between blocks of changed lines (prodivded by gitgutter)

### ultisnips

- `<Tab>`, `<Shift-Tab>` - Expand auto completion and ultisnips, jump forward and backword.
- `<Ctrl-l>` - Show all snippet list in insert mode.

### auto-pairs

- `<Alt-a>` - Toggle auto pairs
- `<Alt-e>` - Fast Wrap
- `<Alt-l>` - Jump to next closed pair

### vim-rsi

- `<Ctrl-a>` - Go to beginning of line.
- `<Ctrl-b>` - Go backwards one character.
- `<Ctrl-d>` - Delete character in front of cursor.
- `<Ctrl-e>` - Go to end of line.
- `<Ctrl-f>` - Move forward one character.
- `<Ctrl-t>` - Transpose two characters.
- `<Alt-BS>` - Delete backward one word.
- `<Alt-b>` - Go backwards one word.
- `<Alt-d>` - Delete forwards one word.
- `<Alt-f>` - Go forwards one word.
- `<Alt-p>`, `<Alt-n>` - Up down

### GB

- `:GB` - Gblame.

### vim-mundo

- `:UT` - Undo tree toggle.

### fzf.vim

- `<Ctrl-p>` - Show fzf window for git project files.
- `<Ctrl-t>`, `<Ctrl-x>`, `<Ctrl-v>` - Open the file in tab, split, vsplit.
- `<Leader>/` - Rg

Commands
---
- `:Files [PATH]` - Files (runs $FZF_DEFAULT_COMMAND if defined)
- `:GFiles [OPTS]` - Git files (git ls-files)
- `:GFiles?` - Git files (git status)
- `:Buffers` - Open buffers
- `:Rg [PATTERN]` - rg search result (ALT-A to select all, ALT-D to deselect all)
- `:Lines [QUERY]` - Lines in loaded buffers
- `:BLines [QUERY]` - Lines in the current buffer
- `:Tags [QUERY]` - Tags in the project (ctags -R)
- `:BTags [QUERY]` - Tags in the current buffer
- `:Marks` - Marks
- `:Windows` - Windows
- `:Locate PATTERN` - locate command output
- `:History` - v:oldfiles and open buffers
- `:History:` - Command history
- `:History/` - Search history
- `:Snippets` - Snippets (UltiSnips)
- `:Commits` - Git commits (requires fugitive.vim)
- `:BCommits` - Git commits for the current buffer
- `:Commands` - Commands
- `:Maps` - Normal mode mappings
- `:Helptags` - Help tags 1
- `:Filetypes` - File types

### vinegar

- `-` - Open netrw directory brower.
- `gh` - Toggle dot file hiding.
- `.`, `!` -  Pre-populate the file at the end of a : or :! command line.
- `y` - Yank an absolute path for the file under the cursor.
- `~` - Go home.
- `<Ctrl-^>`, `<Ctrl-6>` - switching back to the previous buffer from the netrw buffer.

### open-browser

- `gx` - Open URI with browser

### toolbox

- `gk` - search stardict for the word under cursor or the current visual selection.
- `gK` - search goldendict for the word under cursor or the current visual selection.
- `gZ` - search zeal for the word under cursor or the current visual selection.
- `:SD`, `:GD`, `:Z` - stardict & goldendict, zeal command

### vim-go

- `<Ctrl-g>` - Go to declare directory.
- `<Leader>b` - go-build or go-test
- `<Leader>r` - go-run
- `<Leader>R` - go-debug-start
- `<Leader>t` - go-test
- `<Leader>T` - go-debug-test
- `<Leader>n` - go-test-func
- `<Leader>i` - go-info
- `<Leader>e` - go-diagnostics
- `<Leader>ci` - go-imports
- `<Leader>cn` - go-rename
- `<Leader>ce` - go-iferr
- `<Leader>cI` - GoImpl
- `<Leader>gi` - go-implements
- `<Leader>gr` - go-referrers
- `<Leader>gs` - go-def-split
- `<Leader>gv` - go-def-vertical
- `<Leader>gt` - go-def-tab
- `<Leader>gx` - go-doc-browser
- `:A`, `:AS`, `:AV`, `:AT` - go-alternate-switch
- `:GO <pkg>` - go package decls

Debug

---
- `<F5>` - `:GoDebugContinue`, Continue execution until breakpoint or program termination.
- `<F9>` - `:GoDebugBreakpoint`, Toggle breakpoint for the [linenr].
- `<F10>` - `:GoDebugNext`, Advance execution by one line.
- `<F11>` - `:GoDebugStep`, Advance execution by one step, stopping at the next line of code that will be executed.
- `<F6>` - `:GoDebugPrint`, Print the result of a Go expression.
- `:GoDebugStop`, `:GoDebugRestart`, `:GoDebugStepOut`, `:GoDebugSet`

### rust

- `<Leader>b` - build
- `<Leader>r` - run
- `<Leader>t` - test
- `<Leader>e` - check
- `<Leader>ca` - code action
- `<Leader>ci` - imports
- `<Leader>cn` - rename
- `<Leader>gi` - go to implementation
- `<Leader>gr` - find references
- `<Leader>gs` - go to definition in split
- `<Leader>gv` - go to definition in vsplit
- `<Leader>gt` - go to definition in tab
- `<Leader>gx` - open doc in browser

### markdown

- `gx` - open link
- `ge` - open file

### Leader

- `y`, `p`, `a`, `q`, `o`, `w`, `s`, `]`, `/`, `*` - reserved for vim enhancement.
- `<Leader>f` - files related.
- `<Leader>g` - goto, jump, open in buffer, window, tab.
- `<Leader>t` - tab, terminal, tools, test. toggle
- `<Leader>r` - run.
- `<Leader>b` - build.
- `<Leader>i` - info.
- `<Leader>c` - code, change.
- `<Leader>d` - dig, data, find. display in quickfix window.
- `<Leader>z` - zeal.
- `<Leader>s` - substitute, surround
- `<Leader>e` - error, examine, execute.

### TODO

- Don't use a map when a command will do. Vim doesn't even have a map for :write.
- Don't prompt for things. Vim prompts in only a handful of scenarios (e.g. overwriting a changed file) and never asks multiple questions in a row.
---
- cd cg cm co cp cq cu cv cx cy cz
- dc dg dm dq dr du dv dx dy dz
- gb gl gs gy
- vc vd vm vo vp vq vr vs vu vv vx vy vz
- yc yd ym yo yp yq yr ys yu yv yx yz
- zp zq zy

---
- `<Leader>m` - make, move, management.
- `<Leader>l` - lint.
- `<Leader>k` - kill.
- `<Leader>j` - jump.
- `<Leader>n` - navigation.
- `<Leader>v` - reverse
- `<Leader>h` - help
- `<Leader>u` - usage
