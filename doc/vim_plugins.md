# Vim Plugins

## Prefixes

- `<Space>` - Leader
- `\\` - Local Leader
- `:` - Command

## Color Scheme

`gruvbox` - Color scheme.

## Text Objects

- `ia` `aa` - An argument in a list of arguments surrounded by braces and commas. (provided by targets.vim)
- `il` `al` - The current line (provided by vim-textobj-line).
- `ie` `ae` - The entire content of the current buffer (provided by vim-textobj-entire).
- `if`, `af` - Function text objects (provided by vim-go)
- `ic`, `ac` - Comment text objects (provided by vim-go)
- `i%`, `a%` - Any block text objects (provided by match-up)
- `ii`, `ai`, `iI`, `aI` - An Indentation level and line above/below (provided by vim-indent-object)
- `ib`, `ab`, `is`, `as` - Search and select a sandwiched text automatically or with query (provided by vim-sandwich)

## Shortcuts

- `Y` = `y$` - `Y` act like `D` and `C`.
- `U` = `<Ctrl-r>` - `U` for easier redo.
- `gV` - Select last inserted text.
- `<Alt-j>`, `<Alt-k>` - Move lines in normal and visual mode.
- `<Leader>y`, `<Leader>Y`, `<Leader>p`, `<Leader>P` - Copy to and paste from system clipboard.
- `<Leader>w` - Fast saving.
- `<Leader>o` - Close all other windows but the current window.
- `<Leader>O` - Close all other tabs but the current tab.
- `<Leader>q` - Quit the current window.
- `<Leader>Q` - Close the current tab.
- `<Leader>a` - Close the quickfix window.
- `:CC` - Toggle color column.

Tabs

---
- `<Leader>#` - Switch tab by #.
- `<Alt-#>` - Switch tab by Alt-#.

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

### vim-multiple-cursor

- `<Ctrl-n>`

### auto-pairs

- `<Alt-e>` - Fast Wrap
- `<Alt-n>` - Jump to next closed pair

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

### GB

- `:GB` - Gblame.

### vim-mundo

- `:UT` - Undo tree toggle.

### fzf.vim

- `<Ctrl-p>` - Show fzf window for git project files.
- `<Ctrl-t>`, `<Ctrl-x>`, `<Ctrl-v>` - Open the file in tab, split, vsplit.
- `<Leader>fr`, `<Leader>fs` - Fzf rg, snippets.
- `<Leader>/` - Rg line search.

### vinegar

- `-` - Open netrw directory brower.
- `gh` - Toggle dot file hiding.
- `.`, `!` -  Pre-populate the file at the end of a : or :! command line.
- `y` - Yank an absolute path for the file under the cursor.
- `~` - Go home.
- `<Ctrl-^>`, `<Ctrl-6>` - switching back to the previous buffer from the netrw buffer.

### open-browser

- `gx` - Open URI with browser

### zeavim

- `gz{motion/text-object}` - Act like an operator and search for the result of a motion/text-object with the docset defined automatically+ (e.g. gziW will search for the inner Word).
- `<Leader>z` - Search for the word under cursor or the current visual selection with the docset defined automatically.
- `<Leader><Leader>z` - Narrow search with a docset+ and a query (A default docset is provided).

### stardict & goldendict

- `gk`, `gK` - search stardict & goldendict for the word under cursor or the current visual selection.
- `:SD`, `:GD` - stardict & goldendict command

### vim-go

- `<Ctrl-g>` - Go to declare directory.
- `<Leader>b` - go-build or go-test
- `<Leader>B` - go-diagnostics
- `<Leader>r` - go-run
- `<Leader>R` - go-debug-start
- `<Leader>t` - go-test
- `<Leader>T` - go-debug-test
- `<Leader>n` - go-test-func
- `<Leader>i` - go-doc
- `<Leader>e` - go-coverage-toggle
- `<Leader>ce` - GoImpl
- `<Leader>cn` - go-rename
- `<Leader>ci` - go-imports
- `<Leader>ci` - go-imports
- `<Leader>di` - go-implements
- `<Leader>dr` - go-referrers
- `<Leader>ds` - go-describe
- `<Leader>dd` - go-sameids
- `<Leader>gd` - go-def
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

TODO

---
- `<Leader>m` - move, management.
- `<Leader>l` - lint.
- `<Leader>k` - kill.
- `<Leader>j` - jump.
- `<Leader>n` - navigation.
- `<Leader>v` - reverse
- `<Leader>h` - help
- `<Leader>u` - usage
- `<Leader>x` - black tech.
