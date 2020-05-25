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
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-obsession'
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'michaeljsmith/vim-indent-object'
Plug 'svermeulen/vim-subversive'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
" Coding
Plug 'jiangmiao/auto-pairs'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
" File
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf.vim'
" VCS
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-rhubarb'
" Lint
Plug 'dense-analysis/ale'
" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Dart
Plug 'dart-lang/dart-vim-plugin'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
" Markdown
Plug 'plasticboy/vim-markdown'
" Misc
Plug 'cespare/vim-toml'
Plug 'elzr/vim-json', {'for' : 'json'}
" Tools
Plug 'tyru/open-browser.vim'
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
Plug 'KabbAmine/zeavim.vim'
call plug#end()
" }}}

" Settings {{{
set number                      " Enable number
set relativenumber              " Enable relative number
set signcolumn=yes              " Enable sign column
set mouse=a                     " Enable mouse mode
set belloff=all                 " No beeps
set hlsearch                    " Highlight found searches
set showcmd                     " Show me what I'm typing
set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom
set autowriteall                " Automatically save before :next, :make etc.
set hidden                      " Buffer should still exist if window is closed
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set noshowmatch                 " Do not show matching brackets by flickering
set noshowmode                  " We show the mode with airline or lightline
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not it begins with upper case
set smartindent                 " Smart indent
set lazyredraw                  " Wait to redraw
set completeopt=menuone,longest " Complete options
set pumheight=15                " Limit popup menu height
set history=10000               " The maximum value for the history
set diffopt+=internal,algorithm:patience,indent-heuristic " Diff options

" To make Vim more responsive/IDE-like.
set updatetime=500
set balloondelay=250

" Enable to copy to clipboard for operations like yank, delete, change and put
if has('unnamedplus')
  set clipboard^=unnamed
  set clipboard^=unnamedplus
endif

" Disable readonly in diff mode
if &diff
  set noreadonly
endif

" This enables us to undo files even if you exit Vim.
if has('persistent_undo')
  set undofile
endif
" Show info for completion candidates in a popup menu
if has("patch-8.1.1904")
  set completeopt+=popup
  set completepopup=align:menu,border:off,highlight:Pmenu
endif
" }}}

" Colors {{{
set t_Co=256
set background=dark
colorscheme gruvbox
" }}}

" File Types {{{
augroup filetypedetect
  command! -nargs=* -complete=help Help vertical belowright help <args>
  autocmd FileType help wincmd L
  autocmd BufNewFile,BufRead *.ino setlocal noet ts=4 sw=4 sts=4
  autocmd BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.md setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.html setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.vim setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.hcl setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.sh setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.proto setlocal expandtab shiftwidth=2 tabstop=2
  
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
augroup END

augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir)
          \   && (a:force
          \       || input("'" . a:dir . "' does not exist. Create? [y/N]") =~? '^y\%[es]$')
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

" fixes some annoyances
command! Q q
map q: :q

" mimic the behavior of /%Vfoobar which searches within the previously
" selected visual selection
" while in search mode, pressing / will do this
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l

" Visual Mode */# from Scrooloose
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-U>call <SID>VSetSearch()<CR>//<CR><C-O>
vnoremap # :<C-U>call <SID>VSetSearch()<CR>??<CR><C-O>

" Never use a mapping when a command will do! This is Vim!
" Edit .vimrc file
command! Erc :e $MYVIMRC<CR>
command! Src :source $MYVIMRC<CR>
command! Wrc :w | :source $MYVIMRC | :echom ".vimrc saved and reloaded!"

" Leader
let mapleader = "\<Space>"
let maplocalleader = "\\"

" Fast saving
nnoremap <Leader>w :w<CR>
nnoremap <Leader>W :wa<CR>

" Quit the window and tab
noremap <Leader>q :tabclose<CR>
noremap <Leader>Q :wqa<CR>

" Close all but the current one
noremap <Leader>o :only<CR>
noremap <Leader>O :tabonly<CR>

" Close the quickfix window
noremap <Leader>a :cclose <Bar> :lclose <CR>

" Jump to definition in vertical split
nnoremap <Leader>] <C-W>v<C-]>

" s for substitute
nmap s <Plug>(SubversiveSubstitute)
nmap ss <Plug>(SubversiveSubstituteLine)
nmap S <Plug>(SubversiveSubstituteToEndOfLine)
nmap <Leader>s <Plug>(SubversiveSubstituteRange)
xmap <Leader>s <Plug>(SubversiveSubstituteRange)
nmap <Leader>S <Plug>(SubversiveSubvertRange)
xmap <Leader>S <Plug>(SubversiveSubvertRange)
nmap <Leader>ss <Plug>(SubversiveSubstituteWordRange)

" Mappings to make the global register less annoying
if has("clipboard")
  noremap <Leader>p :set paste<CR>"+]p<Esc>:set nopaste<CR>
  noremap <Leader>P :set paste<CR>"+]P<Esc>:set nopaste<CR>
  noremap <Leader>y "+y
  noremap <Leader>Y "+Y
else
  noremap <Leader>p :set paste<CR>:r !xsel -ob<Esc>:set nopaste<CR>
  noremap <Leader>P :set paste<CR>:-1r !xsel -ob<Esc>:set nopaste<CR>
  noremap <Leader>y :w !xsel -ib<CR><CR>
  noremap <Leader>Y <S-v>:w !xsel -ib<CR><CR>
endif

" Terminal settings
if has('terminal')
  " Open terminal in vertical, horizontal and new tab
  command! T  terminal ++kill=term ++curwin ++close
  command! TS below terminal ++kill=term ++close
  command! TV vertical terminal ++kill=term ++close
  command! TT execute "tabnew<Bar>terminal ++kill=term ++curwin ++close"
endif

" <Alt-#> <Leader># switch tabs
function! s:metacode(key)
  exec "set <M-".a:key.">=\e".a:key
endfunc
for i in range(10)
  call s:metacode(nr2char(char2nr('0') + i))
endfor
for i in range(26)
  call s:metacode(nr2char(char2nr('a') + i))
  call s:metacode(nr2char(char2nr('A') + i))
endfor
for i in range(10)
  let c = nr2char(char2nr('0') + i)
  let tc = c
  if tc == '0'
    let tc = "10"
  endif
  exec "noremap <silent> <M-".c."> :tabn ".tc."<CR>"
  exec "inoremap <silent> <M-".c."> <Esc>:tabn ".tc."<CR>"
  exec "tnoremap <silent> <M-".c."> <C-W>:tabn ".tc."<CR>"
  exec "noremap <silent> <Leader>".c." <Esc>:tabn ".tc."<CR>"
endfor
" }}}

" vim-matchup {{{
let g:matchup_matchparen_status_offscreen = 0
let g:matchup_matchparen_enabled = 1
" }}}

" fzf.vim {{{
let g:fzf_command_prefix = 'Fzf'
noremap <silent> <C-P> :ProjectFiles<CR>
nnoremap <silent> <Leader>fb :FzfBuffers<CR>
nnoremap <silent> <Leader>fc :FzfCommands<CR>
nnoremap <silent> <Leader>fg :FzfGFiles?<CR>
nnoremap <silent> <Leader>fh :FzfHistory<CR>
nnoremap <silent> <Leader>fl :FzfLines<CR>
nnoremap <silent> <Leader>fm :FzfMarks<CR>
nnoremap <silent> <Leader>fr :FzfRg<CR>
nnoremap <silent> <Leader>fs :FzfSnippets<CR>
nnoremap <silent> <Leader>ft :FzfTags<CR>

noremap <silent> <M-b> :FzfBuffers<CR>
noremap <silent> <M-c> :FzfCommands<CR>
noremap <silent> <M-g> :FzfGFiles?<CR>
noremap <silent> <M-h> :FzfHistory<CR>
noremap <silent> <M-l> :FzfLines<CR>
noremap <silent> <M-m> :FzfMarks<CR>
noremap <silent> <M-r> :FzfRg<CR>
noremap <silent> <M-s> :FzfSnippets<CR>
noremap <silent> <M-t> :FzfTags<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \  }
function! s:find_files()
  let git_dir = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
  if git_dir != ''
    execute 'FzfFiles' git_dir
  else
    execute 'FzfFiles'
  endif
endfunction
command! ProjectFiles execute s:find_files()
"}}}

" vim-lightline {{{
let g:lightline = {
  \ 'colorscheme': 'gruvbox',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'filename', 'modified' ],  [ 'gostatus' ] ],
  \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ] ],
  \ },   
  \ 'tabline': {
  \   'left': [ [ 'tabs' ] ],
  \   'right': [ ],
  \ },
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
  \ 'separator': {
  \   'left': '', 'right': ''
  \ },
  \ 'subseparator': {
  \   'left': '', 'right': ''
  \ },
  \ }
let g:lightline#ale#indicator_checking = ''
let g:lightline#ale#indicator_infos = ''
let g:lightline#ale#indicator_warnings = ''
let g:lightline#ale#indicator_errors = ''
let g:lightline#ale#indicator_ok = ''

function! LightlineGostatus()
  if ! exists('*go#statusline#Show')
    return ''
  endif
  return winwidth('.') > 70 ? go#statusline#Show() : ''
endfunction
" }}}

" Plugin: auto-pairs {{{
let g:AutoPairsCenterLine = 0
let g:AutoPairsMapSpace = 0
let g:AutoPairsFlyMode = 0
let g:AutoPairsMultilineClose = 0
let g:AutoPairsShortcutJump = '<S-Tab>'
" }}}

" Plugin: supertab {{{
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
" }}}

" Plugin: UltiSnips {{{
let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsJumpForwardTrigger = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"
let g:UltiSnipsListSnippets = "<C-L>"
" }}}

" Plugin: vim-expand-region {{{
call expand_region#custom_text_objects('go', {
  \ 'if' :0,
  \ 'af' :0,
  \ 'ic' :0,
  \ 'ac' :0
  \ })
call expand_region#custom_text_objects('html', {
  \ 'it' :1,
  \ 'at' :1
  \ })
" }}}

" vim-mundo {{{
command! UT MundoToggle
" }}}

" tagbar {{{
command! TB TagbarToggle
let g:tagbar_autofocus = 1
let g:tagbar_expand = 1
let g:tagbar_foldlevel = 2
let g:tagbar_autoshowtag = 1
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
  \ 'dart': ['language_server'],
  \ }
let g:ale_fixers = {
  \ 'go': ['gofmt', 'goimports', 'trim_whitespace', 'remove_trailing_lines'],
  \ 'dart': ['dartfmt'],
  \ }
let g:ale_go_gofmt_options = '-s'
" }}}

" vim-markdown {{{
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = ['go=go', 'viml=vim', 'bash=sh']
let g:vim_markdown_conceal = 0
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_extensions_in_markdown = 0
let g:vim_markdown_edit_url_in = 'tab'

augroup vimrc-markdown
  autocmd!
  autocmd Filetype markdown nnoremap <buffer> <LocalLeader>1 I# <Esc>
  autocmd Filetype markdown nnoremap <buffer> <LocalLeader>2 I## <Esc>
  autocmd Filetype markdown nnoremap <buffer> <LocalLeader>3 I### <Esc>
  autocmd Filetype markdown nnoremap <buffer> <LocalLeader>4 I#### <Esc>
  autocmd Filetype markdown nnoremap <buffer> <LocalLeader>5 I##### <Esc>
  autocmd Filetype markdown nnoremap <buffer> <LocalLeader>6 I###### <Esc>
  autocmd Filetype markdown nnoremap <buffer> <LocalLeader>n I---<Enter><Enter>
  autocmd Filetype markdown nnoremap <buffer> <LocalLeader>h i[]()<Esc>F[a
  autocmd Filetype markdown nnoremap <buffer> <LocalLeader>j i![](/images/)<Esc>F[a
  autocmd Filetype markdown nnoremap <buffer> <LocalLeader>c i```<Enter><Enter>```<Enter><Esc>kO
  autocmd Filetype markdown nnoremap <buffer> <LocalLeader>x 0f[lrx
  autocmd Filetype markdown nnoremap <buffer> <LocalLeader><Space> 0f[lr<Space>
  autocmd Filetype markdown nnoremap <buffer> <LocalLeader>q I> <ESC>
  autocmd Filetype markdown vnoremap <buffer> <LocalLeader>q :s/^/> /<CR>
  autocmd Filetype markdown vnoremap <buffer> <LocalLeader>ul :s/^/- /<CR>
  autocmd Filetype markdown vnoremap <buffer> <LocalLeader>ol :s/^/\=(line(".")-line("'<")+1).'. '/<CR>
  autocmd Filetype markdown vnoremap <buffer> <LocalLeader>tl :s/^/- [ ] /<CR>

  " Surround settings
  autocmd FileType markdown let b:surround_{char2nr('i')} = "_\r_"
  autocmd FileType markdown let b:surround_{char2nr('b')} = "**\r**"
  autocmd FileType markdown let b:surround_{char2nr('c')} = "```\r```"
  autocmd FileType markdown let b:surround_{char2nr('u')} = "<u>\r</u>"
  autocmd FileType markdown let b:surround_{char2nr('d')} = "<del>\r</del>"
  autocmd FileType markdown let b:surround_{char2nr('k')} = "<kbd>\r</kbd>"
  autocmd FileType markdown let b:surround_{char2nr('n')} = "<sub>\r</sub>"
  autocmd FileType markdown let b:surround_{char2nr('p')} = "<sup>\r</sup>"
  autocmd FileType markdown let b:surround_{char2nr('h')} = "\[\r\]\(//\)"
  autocmd FileType markdown let b:surround_{char2nr('e')} = "\[\r\]\(\){:rel=\"nofollow noopener noreferrer\" target=\"_blank\"}"
  autocmd FileType markdown let b:surround_{char2nr('j')} = "\![\r\]\(/images/\){: .align-}"
augroup END
" }}}

" vim-go {{{
let g:go_fmt_autosave = 0
let g:go_debug_windows = {
  \ 'vars': 'leftabove 35vnew',
  \ 'stack': 'botright 10new',
  \ }
let g:go_term_enabled = 0
let g:go_term_mode = "split"
let g:go_term_height = 15
let g:go_term_width = 30
let g:go_term_close_on_exit = 1

let g:go_list_type = "quickfix"
let g:go_echo_command_info = 0

let g:go_info_mode = 'gopls'
let g:go_rename_command = 'gopls'
let g:go_implements_mode = 'gopls'
let g:go_gopls_complete_unimported = 1
let g:go_diagnostics_enabled = 1
let g:go_doc_popup_window = 1
let g:go_auto_type_info = 1

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

augroup vimrc-go
  autocmd!
  autocmd FileType go nmap <silent> <C-G> :GoDeclsDir<CR>
  autocmd FileType go imap <silent> <C-G> <Esc>:<C-U>GoDeclsDir<CR>

  autocmd FileType go nmap <silent> <Leader>b :<C-U>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <silent> <Leader>B <Plug>(go-diagnostics)
  autocmd FileType go nmap <silent> <Leader>r <Plug>(go-run)
  autocmd FileType go nmap <silent> <Leader>R :GoDebugStart<CR>
  autocmd FileType go nmap <silent> <Leader>t <Plug>(go-test)
  autocmd FileType go nmap <silent> <Leader>T :GoDebugTest<CR>
  autocmd FileType go nmap <silent> <Leader>n <Plug>(go-test-func)
  autocmd FileType go nmap <silent> <Leader>i <Plug>(go-doc)
  autocmd FileType go nmap <silent> <Leader>c <Plug>(go-coverage-toggle)

  autocmd FileType go nmap <silent> <Leader>cn <Plug>(go-rename)
  autocmd FileType go nmap <silent> <Leader>ci :GoImpl<CR>

  autocmd FileType go nmap <silent> <Leader>di <Plug>(go-implements)
  autocmd FileType go nmap <silent> <Leader>dr <Plug>(go-referrers)
  autocmd FileType go nmap <silent> <Leader>ds <Plug>(go-describe)
  autocmd FileType go nmap <silent> <Leader>dd :GoSameIdsToggle<CR>

  autocmd FileType go nmap <silent> <Leader>gd <Plug>(go-def)
  autocmd FileType go nmap <silent> <Leader>gs <Plug>(go-def-split)
  autocmd FileType go nmap <silent> <Leader>gv <Plug>(go-def-vertical)
  autocmd FileType go nmap <silent> <Leader>gt <Plug>(go-def-tab)
  autocmd FileType go nmap <silent> <Leader>gx <Plug>(go-doc-browser)

  autocmd Filetype go command! -nargs=? -complete=dir GO call go#decls#Decls(1, '/usr/lib/go/src/'.<q-args>)

  " I like these more!
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>1, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>1, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>1, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>1, 'tabe')
augroup END
" }}}

" open-browser {{{
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" }}}

" stardict & goldendict {{{
function! s:getVSelectOrCword(mode) abort
  if a:mode == "v"
    let l:pos = getpos("'<")
    call setpos('.', l:pos)
    return getline('.')[col("'<") - 1 : col("'>") - 1]
  else
    return expand('<cword>')
  endif
endfunction

function! s:StarDict(word, mode)
  let cmd = 'sdcv -n -e '
  let word = a:word
  if word == ""
    let word = s:getVSelectOrCword(a:mode)
  endif
  let output = system(cmd . word)
  call popup_clear()
  call popup_atcursor(split(output, '\n'), {
    \ 'padding': [1, 1, 1, 1],
    \ 'borderchars': ['-','|','-','|','+','+','+','+'],
    \ "border": [1, 1, 1, 1],
    \ })
endfunction

function! s:GoldenDict(word, mode)
  let cmd = 'goldendict '
  let word = a:word
  if word == ""
    let word = s:getVSelectOrCword(a:mode)
  endif
  call system(cmd . word)
endfunction

command! -nargs=* StarDict call <SID>StarDict(<q-args>, '')
command! -nargs=* GoldenDict call <SID>GoldenDict(<q-args>, '')
command! SD StarDict
command! GD GoldenDict

nmap <silent> gk :call <SID>StarDict('', '')<CR>
vmap <silent> gk :call <SID>StarDict('', 'v')<CR>
nmap <silent> gK :call <SID>GoldenDict('', '')<CR>
vmap <silent> gK :call <SID>GoldenDict('', 'v')<CR>
" }}}

" local .vimrc {{{
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
" }}}
" vim:foldmethod=marker:foldlevel=0
