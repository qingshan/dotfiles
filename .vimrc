" Plugins {{{
call plug#begin('~/.vim/plugged')
" Setting
Plug 'tpope/vim-sensible'
" Appearance
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'gruvbox-community/gruvbox'
" Editing
Plug 'andymass/vim-matchup'
Plug 'machakann/vim-sandwich'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-rsi'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'mattn/vim-textobj-url'
Plug 'michaeljsmith/vim-indent-object'
Plug 'terryma/vim-expand-region'
Plug 'junegunn/vim-easy-align'
Plug 'jiangmiao/auto-pairs'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'machakann/vim-swap'
" File
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" VCS
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
" Coding
Plug 'dense-analysis/ale'
Plug 'rust-lang/rust.vim'
Plug 'jtdowney/vimux-cargo'
Plug 'cespare/vim-toml'
Plug 'elzr/vim-json', {'for' : 'json'}
" Markdown
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'dkarter/bullets.vim'
" Tools
Plug 'preservim/vimux'
Plug 'tyru/open-browser.vim'
Plug 'brglng/vim-im-select'
Plug 'qingshan/vim-toolbox'
Plug 'ojroques/vim-oscyank', {'branch': 'main'}
call plug#end()
" }}}

" Settings {{{
" DRY: some settings are default or set in the system vimrc...
" ...and the plugin vim-sensible
set number                      " Enable number
set relativenumber              " Enable relative number
set signcolumn=yes              " Enable sign column
set mouse=a                     " Enable mouse mode
set belloff=all                 " No beeps
set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom
set autowriteall                " Automatically save before :next, :make etc.
set hidden                      " Buffer should still exist if window is closed
set showcmd                     " Show me what I'm typing
set noshowmatch                 " Do not show matching brackets by flickering
set noshowmode                  " We show the mode with airline or lightline
set smartindent                 " Smart indent
set lazyredraw                  " Wait to redraw
set shortmess-=S                " Show search count message
set shortmess+=c                " suppress annoy completion messages.

" History
set history=10000               " The maximum value for the history
set swapfile                    " enable swapfile
set undofile                    " enable undofile
set nobackup                    " do not keep a backup file

" Temporary files
if exists('$XDG_CACHE_HOME')
  let &g:directory=$XDG_CACHE_HOME
else
  let &g:directory=$HOME . '/.cache'
endif
let &g:undodir=&g:directory . '/vim/undo//'
let &g:backupdir=&g:directory . '/vim/backup//'
let &g:directory.='/vim/swap//'
" Create directories if they doesn't exist
if ! isdirectory(expand(&g:directory))
  silent! call mkdir(expand(&g:directory), 'p', 0700)
endif
if ! isdirectory(expand(&g:backupdir))
  silent! call mkdir(expand(&g:backupdir), 'p', 0700)
endif
if ! isdirectory(expand(&g:undodir))
  silent! call mkdir(expand(&g:undodir), 'p', 0700)
endif

" Searching
set hlsearch                    " Highlight found searches
set incsearch                   " incremental searching
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not it begins with upper case
set gdefault                    " have :s///g flag by default on

" To make Vim more responsive/IDE-like.
set updatetime=500

" Diff options
if has('mac') && $VIM == '/usr/share/vim'
  set diffopt-=internal
elseif has('patch-8.1.0360')
  set diffopt+=algorithm:patience
endif

" Complete options
set completeopt=menuone,longest " Complete options
set pumheight=15                " Limit popup menu height
" Show info for completion candidates in a popup menu
if has('patch-8.1.1904')
  set completeopt+=popup
  set completepopup=align:menu,border:off,highlight:Pmenu
endif
" }}}

" Colors {{{
set t_Co=256
set background=dark
silent! colorscheme gruvbox
" }}}

" File Types {{{
augroup vimrc-filetype
  command! -nargs=* -complete=help Help vertical belowright help <args>
  autocmd FileType help wincmd L
  autocmd BufNewFile,BufRead *.sh setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.hcl setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.proto setlocal expandtab shiftwidth=2 tabstop=2

  autocmd FileType markdown setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType vim setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType html setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType css setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd FileType java setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END

augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir)
      \ && (a:force
      \ || input("'".a:dir."' does not exist. Create? [y/N]") =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END
" }}}

" Mappings {{{
" Act like D and C
nnoremap Y y$

" Remap U to <C-R> for easier redo.
nnoremap U <C-R>

" Select last inserted text
nnoremap gV `[v`]

" Easier indentation
vnoremap < <gv
vnoremap > >gv

" Fixes some annoyances
command! Q q
map q: :q

" skip paragraphs
nnoremap <C-Up> {
nnoremap <C-Down> }

"allow deleting selection without updating the clipboard (yank buffer)
vnoremap x "_x
vnoremap X "_X

" Free for other mappings
nmap Q <Nop>
nmap s <Nop>
nmap S <Nop>
xmap s <Nop>
xmap S <Plug>(operator-sandwich-add)

" Visual Mode */# from Scrooloose
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-U>call <SID>VSetSearch()<CR>//<CR><C-O>
vnoremap # :<C-U>call <SID>VSetSearch()<CR>??<CR><C-O>

" Move between linting errors
nmap [r <Plug>(ale_previous)
nmap ]r <Plug>(ale_next)
nmap [R <Plug>(ale_first)
nmap ]R <Plug>(ale_last)

" Never use a mapping when a command will do! This is Vim!
" Edit .vimrc file
command! Erc :e $MYVIMRC
command! Src :source $MYVIMRC
command! Wrc :w | :source $MYVIMRC | :echom '.vimrc saved and reloaded!'

" Go to the directory of current file
command! CD lcd %:p:h
cabbr <expr> %% expand('%:p:h')

" Leader
let mapleader = "\<Space>"
let maplocalleader = "\\"

" Fast saving
noremap <silent> <Leader>w :<C-U>update<CR>
noremap <silent> <Leader>W :<C-U>wa<CR>

" Quit the window and tab
noremap <silent> <Leader>q :<C-U>tabclose<CR>
noremap <silent> <Leader>Q :<C-U>wqa<CR>

" Close all but the current one
noremap <silent> <Leader>o :<C-U>only<CR>
noremap <silent> <Leader>O :<C-U>tabonly<CR>

" Close the quickfix window
noremap <silent> <Leader>x :<C-U>cclose <Bar> :lclose <CR>

" Jump to definition in vertical split
noremap <Leader>] <C-W>v<C-]>

" Mappings to make the global register less annoying
if has('clipboard')
  nnoremap <silent> <Leader>p :set paste<CR>"+]p<Esc>:set nopaste<CR>
  nnoremap <silent> <Leader>P :set paste<CR>"+]P<Esc>:set nopaste<CR>
  nnoremap <silent> <Leader>y "+yy
  vnoremap <silent> <Leader>y "+y
elseif executable('xsel')
  nnoremap <silent> <Leader>p :set paste<CR>:r !xsel -ob<Esc>:set nopaste<CR>
  nnoremap <silent> <Leader>P :set paste<CR>:-1r !xsel -ob<Esc>:set nopaste<CR>
  nnoremap <silent> <Leader>y <S-v>:w !xsel -ib<CR><CR>
  vnoremap <silent> <Leader>y :w !xsel -ib<CR><CR>
else
  nnoremap <Leader>y V:OSCYank<CR>
  vnoremap <leader>y :OSCYank<CR>
endif

" Terminal settings
if has('terminal')
  " Open terminal in vertical, horizontal and new tab
  command! T  terminal ++kill=term ++curwin ++close
  command! TS below terminal ++kill=term ++close
  command! TV vertical terminal ++kill=term ++close
  command! TT exec 'tabnew<Bar>terminal ++kill=term ++curwin ++close'
endif

" <Alt-#> <Leader># switch tabs
for i in range(10)
  let c = nr2char(char2nr('0') + i)
  let tc = (c == '0') ? '10' : c
  exec 'noremap  <silent> <M-'.c.'> '.tc.'gt'
  exec 'inoremap <silent> <M-'.c.'> <C-O>'.c.'gt'
  exec 'tnoremap <silent> <M-'.c.'> <C-W>'.tc.'gt'
  exec 'noremap  <silent> <Leader>'.c.' '.tc.'gt'
endfor

" Move lines
nnoremap <silent> <C-j> :m .+1<CR>==
nnoremap <silent> <C-k> :m .-2<CR>==
inoremap <silent> <C-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <C-k> <Esc>:m .-2<CR>==gi
vnoremap <silent> <C-j> :m '>+1<CR>gv=gv
vnoremap <silent> <C-k> :m '<-2<CR>gv=gv

function! s:colorcolumn_toggle()
  if &colorcolumn == 0
    let &colorcolumn = 81
  else
    let &colorcolumn = 0
  endif
endfunction
command! CC exec s:colorcolumn_toggle()
" }}}

" vim-sandwich {{{
silent! call operator#sandwich#set('all', 'all', 'highlight', 0)

function! s:quick_surround(t, c)
  if a:t == ''
    exec 'nmap <LocalLeader>s'.a:c.' saiw'.a:c
    exec 'nmap <LocalLeader>S'.a:c.' saiW'.a:c
  else
    exec 'autocmd Filetype '.a:t.' nmap <LocalLeader>s'.a:c.' saiw'.a:c
    exec 'autocmd Filetype '.a:t.' nmap <LocalLeader>S'.a:c.' saiW'.a:c
  endif
endfunc

" Surround shortcuts for the current word/WORD
for c in ['(', ')', '{', '}', '[', ']', '<', '>', '"', "'", '`']
  call s:quick_surround('', c)
endfor
" }}}

" vim-matchup {{{
let b:matchup_matchparen_enabled = 0
let g:matchup_matchparen_status_offscreen = 0
let g:matchup_matchparen_enabled = 1
" }}}

" vim-swap {{{
omap ia <Plug>(swap-textobject-i)
xmap ia <Plug>(swap-textobject-i)
omap aa <Plug>(swap-textobject-a)
xmap aa <Plug>(swap-textobject-a)
" }}}

" fzf.vim {{{
noremap  <silent> <C-P> :<C-U>ProjectFiles<CR>
noremap  <silent> <C-G>c; :<C-U>Commands<CR>
noremap  <silent> <C-G>n; :<C-U>Maps<CR>
noremap  <silent> <C-G>s :<C-U>Snippets<CR>
noremap  <silent> <C-G>b :<C-U>Buffers<CR>
inoremap  <silent> <C-G>b <Esc>:<C-U>Buffers<CR>
noremap  <silent> <C-G>f :<C-U>Files %:h<CR>
inoremap  <silent> <C-G>f <Esc>:<C-U>Files %:h<CR>
noremap  <silent> <C-G>g :<C-U>GFiles?<CR>
inoremap  <silent> <C-G>g <Esc>:<C-U>GFiles?<CR>
noremap  <silent> <C-G>h :<C-U>History<CR>
inoremap  <silent> <C-G>h <Esc>:<C-U>History<CR>
noremap  <silent> <C-G>m :<C-U>Marks<CR>
inoremap  <silent> <C-G>m <Esc>:<C-U>Marks<CR>
noremap  <silent> <C-G>t :<C-U>Tags<CR>
inoremap  <silent> <C-G>t <Esc>:<C-U>Tags<CR>
noremap  <silent> <C-G>w :<C-U>Windows<CR>
inoremap  <silent> <C-G>w <Esc>:<C-U>Windows<CR>
noremap  <silent> <C-G>/ :<C-U>BLines<CR>
inoremap  <silent> <C-G>/ <Esc>:<C-U>BLines<CR>
noremap  <silent> <C-G>? :<C-U>DLines<CR>
inoremap  <silent> <C-G>? <Esc>:<C-U>DLines<CR>

function! s:find_files()
  let git_dir = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
  if git_dir != ''
    exec 'Files' git_dir
  else
    exec 'Files'
  endif
endfunction
command! ProjectFiles call s:find_files()

command! -bang -nargs=* DLines
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': expand('%:h')}), <bang>0)
"}}}

" vim-lightline {{{
let g:lightline = {
  \ 'colorscheme': 'gruvbox',
  \ 'active': {
  \   'left': [['mode', 'paste'], ['readonly', 'filename', 'modified'], ['gostatus']],
  \   'right': [['lineinfo'], ['percent'], ['linter_checking',
  \     'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok']],
  \ },
  \ 'tabline': { 'left': [[ 'tabs' ]], 'right': [] },
  \ 'component': {
  \   'gostatus': '%#goStatuslineColor#%{LightlineGostatus()}%*',
  \ },
  \ 'component_expand': {
  \   'linter_checking': 'lightline#ale#checking',
  \   'linter_infos': 'lightline#ale#infos',
  \   'linter_warnings': 'lightline#ale#warnings',
  \   'linter_errors': 'lightline#ale#errors',
  \   'linter_ok': 'lightline#ale#ok',
  \ },
  \ 'component_type': {
  \   'linter_checking': 'right',
  \   'linter_infos': 'right',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'right',
  \   'gostatus': 'raw',
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' },
  \ }
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"

function! LightlineGostatus()
  if ! exists('*go#statusline#Show')
    return ''
  endif
  return winwidth('.') > 70 ? go#statusline#Show() : ''
endfunction
" }}}

" vim-easy-align {{{
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
" }}}

" auto-pairs {{{
let g:AutoPairsCenterLine = 0
let g:AutoPairsMapSpace = 0
let g:AutoPairsFlyMode = 0
let g:AutoPairsMultilineClose = 0
let g:AutoPairsMapCh = 0
let g:AutoPairsShortcutToggle = '<M-a>'
let g:AutoPairsShortcutJump = '<M-l>'
let g:AutoPairsShortcutFastWrap = '<M-e>'
let g:AutoPairsShortcutBackInsert = ''
" }}}

" vim-expand-region {{{
silent! call expand_region#custom_text_objects('go', {
  \ 'if': 0,
  \ 'af': 0,
  \ 'ic': 0,
  \ 'ac': 0
  \ })
silent! call expand_region#custom_text_objects('html', {
  \ 'it': 1,
  \ 'at': 1
  \ })
" }}}

" vim-fugitive {{{
cabbrev GB Gblame
" }}}

" vim-mundo {{{
cabbrev UT MundoToggle
" }}}

" ale {{{
let g:ale_lint_on_text_changed = 'never'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_linters = {
  \ 'go': ['gopls'],
  \ 'rust': ['analyzer'],
  \ 'java': ['javac'],
  \ 'markdown': ['mdl'],
  \ 'proto': ['buf-check-lint',],
  \ }
let g:ale_fixers = {
  \ 'go': ['gofmt', 'goimports'],
  \ 'rust': ['rustfmt'],
  \ '*': ['trim_whitespace', 'remove_trailing_lines'],
  \ }
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters_explicit = 1

let g:ale_completion_enabled = 1 " Allow autocompletion
let g:ale_completion_autoimport = 1 " Allow autocompletion of imports
let g:ale_set_balloons = 1 " Show hover info in balloon
let g:ale_hover_to_floating_preview = 1
set omnifunc=ale#completion#OmniFunc

let g:ale_go_gofmt_options = '-s'
let g:ale_rust_cargo_use_clippy = 1
let g:ale_rust_cargo_check_tests = 1
let g:ale_rust_cargo_check_examples = 1
" }}}

" vim-markdown {{{
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = ['go=go', 'rust=rs', 'viml=vim', 'bash=sh']
let g:vim_markdown_conceal = 0
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_extensions_in_markdown = 0
let g:vim_markdown_edit_url_in = 'tab'
let g:vim_markdown_auto_insert_bullets = 0

augroup vimrc-markdown
  autocmd!
  autocmd Filetype markdown nmap <LocalLeader>1 I# <Esc>
  autocmd Filetype markdown nmap <LocalLeader>2 I## <Esc>
  autocmd Filetype markdown nmap <LocalLeader>3 I### <Esc>
  autocmd Filetype markdown nmap <LocalLeader>4 I#### <Esc>
  autocmd Filetype markdown nmap <LocalLeader>5 I##### <Esc>
  autocmd Filetype markdown nmap <LocalLeader>6 I###### <Esc>
  autocmd Filetype markdown nmap <LocalLeader>n I---<CR><CR>
  autocmd Filetype markdown nmap <LocalLeader>h i[]()<Esc>F[a
  autocmd Filetype markdown nmap <LocalLeader>j i![](/images/)<Esc>F[a
  autocmd Filetype markdown nmap <LocalLeader><Space> 0f[lr<Space>
  autocmd Filetype markdown nmap <LocalLeader>q I> <Esc>
  autocmd Filetype markdown vmap <LocalLeader>q :s/^/> /<CR>
  autocmd Filetype markdown vmap <LocalLeader>ul :s/^/- /<CR>
  autocmd Filetype markdown vmap <LocalLeader>ol :s/^/\=(line(".")-line("'<")+1).'. '/<CR>
  autocmd Filetype markdown vmap <LocalLeader>tl :s/^/- [ ] /<CR>
  autocmd Filetype markdown nnoremap <LocalLeader>` i```<CR>```<CR><Esc>kO

  autocmd FileType markdown nmap <silent> <Leader>r :<C-U>MDP<CR>
  autocmd FileType markdown vmap <silent> <Leader>r :<C-U>MDP<CR>
  autocmd FileType markdown nmap <silent> <Leader>ch :MarkdownLink<CR>
  autocmd FileType markdown vmap <silent> <Leader>ch :MarkdownLink<CR>
  autocmd FileType markdown nmap <silent> <Leader>ct :TableFormat<CR>

  autocmd Filetype markdown command! MDP execute 'read ! markdown_previewer' expand('%')

  " Surround settings
  autocmd FileType markdown call sandwich#util#addlocal([
    \ {'buns': ['_', '_'], 'nesting': 0, 'input': ['i']},
    \ {'buns': ['**', '**'], 'nesting': 0, 'input': ['s']},
    \ {'buns': ['```', '```'], 'nesting': 0, 'input': ['c'],
    \   'indentkeys': '{,},0{,0}'},
    \ {'buns': ['<u>', '</u>'], 'nesting': 0, 'input': ['u']},
    \ {'buns': ['<del>', '</del>'], 'nesting': 0, 'input': ['d']},
    \ {'buns': ['<kbd>', '</kbd>'], 'nesting': 0, 'input': ['k']},
    \ {'buns': ['<sup>', '</sup>'], 'nesting': 0, 'input': ['p']},
    \ {'buns': ['<sub>', '</sub>'], 'nesting': 0, 'input': ['n']},
    \ {'buns': ['[', ']()'], 'nesting': 0, 'input': ['h'],
    \   'action': ['add'], 'kind': ['add', 'replace']},
    \ {'buns': ['[', ']([^)]*)'], 'nesting': 0, 'regex': 1, 'input': ['h'],
    \   'action': ['delete'], 'kind': ['delete', 'replace', 'textobj']},
    \ ])

  " Surround shortcuts
  for c in ['i', 's', 'c', 'u', 'd', 'k', 'n', 'p', 'h']
    call s:quick_surround('markdown', c)
  endfor
augroup END
" }}}

" rust {{{
augroup vimrc-rust
  autocmd!
  autocmd FileType rust nmap <silent> <Leader>b :wa<CR> :CargoBuild<CR>
  autocmd FileType rust nmap <silent> <Leader>r :wa<CR> :CargoUnitTestCurrentFile<CR>
  autocmd FileType rust nmap <silent> <Leader>R :wa<CR> :CargoRun<CR>
  autocmd FileType rust nmap <silent> <Leader>t :wa<CR> :CargoUnitTestFocused<CR>
  autocmd FileType rust nmap <silent> <Leader>T :wa<CR> :CargoTestAll<CR>
  autocmd FileType rust nmap <silent> <Leader>e :Ccheck<CR>

  autocmd FileType rust nmap <silent> <Leader>ca <Plug>(ale_code_action)
  autocmd FileType rust nmap <silent> <Leader>ci <Plug>(ale_import)
  autocmd FileType rust nmap <silent> <Leader>cn <Plug>(ale_rename)

  autocmd FileType rust nmap <silent> <Leader>gr <Plug>(ale_find_references)
  autocmd FileType rust nmap <silent> <Leader>gi <Plug>(ale_go_to_implementation)
  autocmd FileType rust nmap <silent> <Leader>gs <Plug>(ale_go_to_definition_in_split)
  autocmd FileType rust nmap <silent> <Leader>gv <Plug>(ale_go_to_definition_in_vsplit)
  autocmd FileType rust nmap <silent> <Leader>gt <Plug>(ale_go_to_definition_in_tab)

  autocmd FileType rust nmap <buffer> K <Plug>(ale_hover)
  autocmd FileType rust nmap <silent> gd <Plug>(ale_go_to_definition)
  autocmd FileType rust nmap <silent> gD <Plug>(ale_go_to_type_definition)
augroup END
" }}}

" vimux {{{
let g:VimuxOrientation = "v"
let g:VimuxHeight = "25"
" }}}

" open-browser {{{
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
let g:openbrowser_search_engines = {
  \ 'wiki': 'http://en.wikipedia.org/wiki/{query}',
  \ 'devdocs': 'http://devdocs.io/#q={query}',
  \ 'duckduckgo': 'http://duckduckgo.com/?q={query}',
  \ 'github': 'http://github.com/search?q={query}',
  \ 'google': 'http://google.com/search?q={query}',
  \ 'rsd': 'https://docs.rs/releases/search?query={query}',
  \ 'rust': 'https://doc.rust-lang.org/nightly/std/index.html?search={query}',
  \ 'crates.io': 'https://crates.io/search?q={query}',
  \ 'go': 'https://pkg.go.dev/search?q={query}',
  \ 'stackoverflow': 'https://stackoverflow.com/search?q={query}',
  \ }
" }}}

" vim-toolbox {{{
nmap <silent> gk :call toolbox#dict#stardict('', '')<CR>
vmap <silent> gk :<C-U>call toolbox#dict#stardict('', 'v')<CR>
nmap <silent> gK :call toolbox#dict#goldendict('', '')<CR>
vmap <silent> gK :<C-U>call toolbox#dict#goldendict('', 'v')<CR>
nmap <silent> gZ :call toolbox#zeal#open('', '')<CR>
vmap <silent> gZ :<C-U>call toolbox#zeal#open('', 'v')<CR>

cabbrev SD StarDict
cabbrev GD GoldenDict
cabbrev Z Zeal
" }}}


" tags {{{
command! Todo   noautocmd vimgrep /TODO\|FIXME/j ** | cw
command! MkTags noautocmd !gotags -R -sort * > tags
" }}}

" local .vimrc {{{
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
" }}}
" vim:foldmethod=marker:foldlevel=0
