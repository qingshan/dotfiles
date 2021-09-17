# IdeaVim

## Prefixes

- `<Space>` - Leader
- `\` - Local Leader
- `:` - Command

## Text Objects

- `i,`, `a,`, `ia`, `aa` - An argument in a list of arguments surrounded by braces and commas. (provided by argtextobj)
- `ie`, `ae` - The entire content of the current buffer (provided by textobj-entire).
- `ii`, `ai`, `iI`, `aI` - An Indentation level and line above/below (provided by textobj-indent)

## Shortcuts

- `<Ctrl-j>`, `<Ctrl-k>` - Move lines in normal and visual mode.
- `<Leader>y`, `<Leader>Y`, `<Leader>p`, `<Leader>P` - Copy to and paste from system clipboard.
- `<Leader>w` - Fast saving.
- `<Leader>o` - Close all other windows but the current window.
- `<Leader>O` - Close all other tabs but the current tab.
- `<Leader>q` - Quit the current window.
- `<Leader>Q` - Close the current tab.
- `<Leader>a` - Hide all windows.
- `<Leader>z` - Distraction free mode.
- `<Leader>Z` - Zen mode.
- `<Leader>x` - Run anything.
- `<Leader>]` - Jump to definition in vertical split.
- `<Leader>/` or `<Leader>*` - Find in path.
- `<Leader>\` - Replace in path.

Tabs

---
- `[b`, `]b` - Previous or next tab.
- `<Leader>#` - Switch tab by #.

Terminal

---
- `:TT` - Open terminal tool window
- `:TD` - Open TODO tool window
- `:SS` - Open Services tool window
- `:RT` - Open Run tool window
- `:DT` - Open Debug tool window
- `:ST` - Open Structure tool window
- `:FT` - Open Favorites tool window
- `:GT` - Open Git tool window
- `:UT` - Open Undo history window.

## Plugins

- `+`, `_` - Expand and shrink the visual selection.
- `<Ctrl-l>` - Clear highlighted text in normal mode

### vim-sandwich

- `sa{motion}{surround_char}` - Add surrounding, e.g.: `saiw(`
- `sd{surround_char}` - Delete surrounding, e.g.: `dst`
- `sr{target_char}{surround_char}` - Change surrounding, , e.g.: `sr'"`
- `sdb`, `srb` - Searchs a set of surrounding automatically.

### vim-abolish

- `crm` - Convert to MixedCase
- `crc` - Convert to camelCase
- `crs` - Convert to snake_case
- `cru` - Convert to UPPER_CASE

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

- `[b`, `]b` - Buffers(bp, bn, bfirst, blast)
- `[q`, `]q` - Occurrence
- `[<Space>`, `]<Space>` - new line above/below
- `[s`, `]s` - exchange statement above/below
- `[e`, `]e` - exchange line above/below
- `[c`, `]c` - Quick jumping between blocks of changed lines (prodivded by gitgutter)
- `[r`, `]r` - Error
- `g[`, `g]` - Go to outer code block.

### vim-rsi

- `<Ctrl-a>` - Go to beginning of line.
- `<Ctrl-e>` - Go to end of line.

### Git

- `:GA` - Qucklist popup actions.
- `:GH` - Show history.
- `:GU` - Update project.
- `:GP` - Push.
- `:GC` - Changes.
- `:GD` - Diff.

### Files

- `<Ctrl-n>` - Show project file explorer.
- `<Ctrl-p>` -  Find in project files.
- `<Leader>/` - Find in path.

### tools

- `gx` - Search with browser.
- `gK` - search translation for the word under cursor or the current visual selection.
- `gZ` - search in devdocs.io.
- `yp` - Copy path.
- `yr` - Copy reference.

### idea

- `<Ctrl-g>` - find and go
- `<Leader>b` - build
- `<Leader>B` - rebuild
- `<Leader>r` - run
- `<Leader>R` - debug
- `<Leader>t` - test
- `<Leader>T` - failed tests
- `<Leader>ia` - show intension actions
- `<Leader>ip` - parameter info
- `<Leader>ir` - expression type info
- `<Leader>ie` - show error description
- `<Leader>ii` - show implementation
- `<Leader>gs` - go to super method
- `<Leader>gi` - go to implementation
- `<Leader>gr` - go to related
- `<Leader>gd` - go to type declaration
- `<Leader>gt` - go to test
- `<Leader>df` - find usages
- `<Leader>du` - show usages
- `<Leader>dc` - call hierarchy
- `<Leader>dt` - type hierarchy
- `<Leader>cr` - reformat
- `<Leader>cg` - generate
- `<Leader>cs` - surround with
- `<Leader>cS` - surround with template
- `<Leader>co` - override methods
- `<Leader>cm` - implment methods
- `<Leader>ci` - optimize imports
- `<Leader>mv` - rename
- `<Leader>mr` - refactor
- `<Leader>e` - execute
