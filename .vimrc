" Plugins {{{
call plug#begin('~/.vim/plugged')
" Setting
Plug 'tpope/vim-sensible'
Plug 'myusuf3/numbers.vim'
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
set completeopt=longest,menuone " Show popup menu, even if there is one entry
set lazyredraw                  " Wait to redraw
set diffopt+=internal,algorithm:patience,indent-heuristic

" Enable to copy to clipboard for operations like yank, delete, change and put
if has('unnamedplus')
  set clipboard^=unnamed
  set clipboard^=unnamedplus
endif

" This enables us to undo files even if you exit Vim.
if has('persistent_undo')
  set undofile
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

" Remap U to <C-r> for easier redo.
nnoremap U <C-r>

" Visual Mode */# from Scrooloose
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>

" Leader
let mapleader="\<Space>"

" Close the quickfix window with <leader>q
nnoremap <leader>q :cclose<CR>

" Close all but the current one
nnoremap <leader>o :only<CR>

" s for substitute
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
nmap <leader>s <plug>(SubversiveSubvertRange)
xmap <leader>s <plug>(SubversiveSubvertRange)
nmap <leader>ss <plug>(SubversiveSubvertWordRange)

" Mappings to make the global register less annoying
if has("clipboard")
  noremap <leader>p :set paste<CR>"+]p<Esc>:set nopaste<CR>
  noremap <leader>P :set paste<CR>"+]P<Esc>:set nopaste<CR>
  noremap <leader>y "+y
  noremap <leader>Y "+Y
else
  noremap <leader>p :set paste<CR>:r !xsel -ob<Esc>:set nopaste<CR>
  noremap <leader>P :set paste<CR>:-1r !xsel -ob<Esc>:set nopaste<CR>
  noremap <leader>y :w !xsel -ib<CR><CR>
  noremap <leader>Y <S-v>:w !xsel -ib<CR><CR>
endif

" Terminal settings
if has('terminal')
  " Kill job and close terminal window
  tnoremap <Leader>q <C-w><C-C><C-w>c<cr>

  " Open terminal in vertical, horizontal and new tab
  nnoremap <leader>tv :vsplit<cr>:term ++curwin<CR>
  nnoremap <leader>ts :split<cr>:term ++curwin<CR>
  nnoremap <leader>tt :tabnew<cr>:term ++curwin<CR>

endif

noremap <silent><leader>1 :tabn 1<cr>
noremap <silent><leader>2 :tabn 2<cr>
noremap <silent><leader>3 :tabn 3<cr>
noremap <silent><leader>4 :tabn 4<cr>
noremap <silent><leader>5 :tabn 5<cr>
noremap <silent><leader>6 :tabn 6<cr>
noremap <silent><leader>7 :tabn 7<cr>
noremap <silent><leader>8 :tabn 8<cr>
noremap <silent><leader>9 :tabn 9<cr>
noremap <silent><leader>0 :tabn 10<cr>

noremap <silent> <leader>tc :tabnew<cr>
noremap <silent> <leader>tq :tabclose<cr>
noremap <silent> <leader>tn :tabnext<cr>
noremap <silent> <leader>tp :tabprev<cr>
noremap <silent> <leader>to :tabonly<cr>

function! Tab_MoveLeft()
  let l:tabnr = tabpagenr() - 2
  if l:tabnr >= 0
    exec 'tabmove '.l:tabnr
  endif
endfunc

function! Tab_MoveRight()
  let l:tabnr = tabpagenr() + 1
  if l:tabnr <= tabpagenr('$')
    exec 'tabmove '.l:tabnr
  endif
endfunc

noremap <silent><leader>tl :call Tab_MoveLeft()<cr>
noremap <silent><leader>tr :call Tab_MoveRight()<cr>
" }}}

" vim-fugitive {{{
vnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gb :Gblame<CR>
" }}}

" fzf.vim {{{
let g:fzf_command_prefix = 'Fzf'
noremap <silent> <C-p> :FzfGFiles<Cr>
nnoremap <silent> <leader>fb :FzfBuffers<Cr>
nnoremap <silent> <leader>fg :FzfGFiles?<Cr>
nnoremap <silent> <leader>fl :FzfBLines<Cr>
nnoremap <silent> <leader>fL :FzfLines<Cr>
nnoremap <silent> <leader>fh :FzfHistory<Cr>
nnoremap <silent> <leader>fc :FzfCommands<Cr>
nnoremap <silent> <leader>fm :FzfMarks<Cr>
nnoremap <silent> <leader>fs :FzfSnippets<Cr>
nnoremap <silent> <leader>ft :FzfBTags<Cr>
nnoremap <silent> <leader>fT :FzfTags<Cr>
nnoremap <silent> <leader>fr :FzfRg<Cr>
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
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsListSnippets="<c-l>"
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
  \ 'go': ['gometalinter'],
  \ 'dart': ['language_server'],
  \ }
let g:ale_fixers = {
  \ 'go': ['gofmt', 'goimports', 'trim_whitespace', 'remove_trailing_lines'],
  \ 'dart': ['dartfmt'],
  \ }
let g:ale_go_gofmt_options = '-s'

" ALE gometalinter settings
let g:ale_go_gometalinter_executable = 'gometalinter'
let g:ale_go_gometalinter_options = '--vendor'
  \ . ' --disable-all'
  \ . ' --enable=vet'
  \ . ' --enable=ineffassign'
  \ . ' --enable=goconst'
  \ . ' --tests'
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
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>

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
  autocmd FileType go nmap <silent> <Leader>h <Plug>(go-def-split)
  autocmd FileType go nmap <silent> <Leader>d <Plug>(go-def-tab)

  autocmd FileType go nmap <silent> <Leader>x <Plug>(go-doc-vertical)

  autocmd FileType go nmap <silent> <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)

  autocmd FileType go nmap <silent> <leader>b :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <silent> <leader>t  <Plug>(go-test)
  autocmd FileType go nmap <silent> <leader>r  <Plug>(go-run)
  autocmd FileType go nmap <silent> <leader>e  <Plug>(go-install)

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
