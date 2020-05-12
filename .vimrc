" Plugins {{{
call plug#begin('~/.vim/plugged')
" Setting
Plug 'tpope/vim-sensible'
" Appearance
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'morhetz/gruvbox'
" Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-vinegar'
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'svermeulen/vim-subversive'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'ervandew/supertab'
" File
Plug 'junegunn/fzf.vim'
" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Lint
Plug 'dense-analysis/ale'
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Dart
Plug 'dart-lang/dart-vim-plugin'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
" Misc
Plug 'plasticboy/vim-markdown'
Plug 'cespare/vim-toml'
Plug 'elzr/vim-json', {'for' : 'json'}
" Tools
Plug 'tyru/open-browser.vim'
call plug#end()
" }}}

" Settings {{{
set number                      " Enable number
set relativenumber              " Enable relative number
set mouse=a                     " Enable mouse mode
set belloff=all                 " No beeps
set hlsearch                    " Highlight found searches
set showcmd                     " Show me what I'm typing
set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom
set autowrite                   " Automatically save before :next, :make etc.
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
set diffopt+=internal,algorithm:patience,indent-heuristic " Diff options

" To make Vim more responsive/IDE-like.
set updatetime=500
set balloondelay=250

" Enable to copy to clipboard for operations like yank, delete, change and put
if has('unnamedplus')
  set clipboard^=unnamed
  set clipboard^=unnamedplus
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
" }}}

" Mappings {{{
" Act like D and C
nnoremap Y y$

" Remap U to <C-R> for easier redo.
nnoremap U <C-R>

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

" Leader
let mapleader="\<Space>"

" Fast saving
nnoremap <Leader>w :w!<CR>

" Quit the window and tab
noremap <Leader>q :q<CR>
noremap <Leader>Q :tabclose<CR>

" Close all but the current one
noremap <Leader>o :only<CR>
noremap <Leader>O :tabonly<CR>

" Close the quickfix window
noremap <Leader>a :cclose<CR>

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
  " Kill job and close terminal window
  tnoremap <Leader>q <C-W><C-C><C-W>c<CR>

  " Open terminal in vertical, horizontal and new tab
  nnoremap <Leader>tv :vsplit<CR>:term ++curwin<CR>
  nnoremap <Leader>ts :split<CR>:term ++curwin<CR>
  nnoremap <Leader>tt :tabnew<CR>:term ++curwin<CR>

  tnoremap <Leader>tv <C-W>:vsplit<CR>:term ++curwin<CR>
  tnoremap <Leader>ts <C-W>:split<CR>:term ++curwin<CR>
  tnoremap <Leader>tt <C-W>:tabnew<CR>:term ++curwin<CR>
endif

noremap <silent> <Leader>1 :tabn 1<CR>
noremap <silent> <Leader>2 :tabn 2<CR>
noremap <silent> <Leader>3 :tabn 3<CR>
noremap <silent> <Leader>4 :tabn 4<CR>
noremap <silent> <Leader>5 :tabn 5<CR>
noremap <silent> <Leader>6 :tabn 6<CR>
noremap <silent> <Leader>7 :tabn 7<CR>
noremap <silent> <Leader>8 :tabn 8<CR>
noremap <silent> <Leader>9 :tabn 9<CR>
noremap <silent> <Leader>0 :tabn 10<CR>
nnoremap <C-S-t> :tabnew<CR>
inoremap <C-S-t> <Esc>:tabnew<CR>
" }}}

" vim-fugitive {{{
vnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gb :Gblame<CR>
" }}}

" fzf.vim {{{
let g:fzf_command_prefix = 'Fzf'
noremap <silent> <C-P> :FzfGFiles<CR>
nnoremap <silent> <Leader>fb :FzfBuffers<CR>
nnoremap <silent> <Leader>fg :FzfGFiles?<CR>
nnoremap <silent> <Leader>fl :FzfBLines<CR>
nnoremap <silent> <Leader>fL :FzfLines<CR>
nnoremap <silent> <Leader>fh :FzfHistory<CR>
nnoremap <silent> <Leader>fc :FzfCommands<CR>
nnoremap <silent> <Leader>fm :FzfMarks<CR>
nnoremap <silent> <Leader>fs :FzfSnippets<CR>
nnoremap <silent> <Leader>ft :FzfBTags<CR>
nnoremap <silent> <Leader>fT :FzfTags<CR>
nnoremap <silent> <Leader>fr :FzfRg<CR>
set grepprg=rg\ -S\ --vimgrep
"}}}

" Plugin: vim-lightline {{{
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
let g:UltiSnipsListSnippets="<C-L>"
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

" Plugin: ale {{{
let g:ale_lint_on_text_changed = 'never'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_sign_column_always = 1
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

" Plugin: vim-markdown {{{
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = ['go=go', 'viml=vim', 'bash=sh']
let g:vim_markdown_conceal = 0
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_extensions_in_markdown = 1
" }}}

" Plugin: vim-go {{{
let g:go_fmt_autosave = 0
let g:go_debug_windows = {
  \ 'vars': 'leftabove 35vnew',
  \ 'stack': 'botright 10new',
  \ }

let g:go_list_type = "quickfix"
let g:go_echo_command_info = 0

let g:go_info_mode = 'gopls'
let g:go_rename_command='gopls'
let g:go_implements_mode='gopls'
let g:go_gopls_complete_unimported = 1
let g:go_diagnostics_enabled = 1
let g:go_doc_popup_window = 1

" Open :GoDeclsDir with ctrl-g
nmap <C-G> :GoDeclsDir<CR>
imap <C-G> <esc>:<C-U>GoDeclsDir<CR>

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

augroup go
  autocmd!

  autocmd FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical)
  autocmd FileType go nmap <silent> <Leader>d <Plug>(go-def-tab)

  autocmd FileType go nmap <silent> <Leader>x <Plug>(go-doc-vertical)

  autocmd FileType go nmap <silent> <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)

  autocmd FileType go nmap <silent> <Leader>b :<C-U>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <silent> <Leader>t <Plug>(go-test)
  autocmd FileType go nmap <silent> <Leader>r <Plug>(go-run)

  autocmd FileType go nmap <silent> <Leader>c <Plug>(go-coverage-toggle)

  " I like these more!
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END
" }}}

" Plugin: open-brower {{{
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" }}}

" Source a local configuration file if available. {{{
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
" }}}
" vim:foldmethod=marker:foldlevel=0
