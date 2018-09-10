call plug#begin('~/.vim/plugged')
" Editing
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'wellle/targets.vim'
Plug 'Raimondi/delimitMate'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-endwise'
" Appearance
Plug 'vim-airline/vim-airline'
Plug 'fatih/molokai'
Plug 'myusuf3/numbers.vim'
" Navigation
Plug 'scrooloose/nerdtree'
" Search
Plug 'ctrlpvim/ctrlp.vim'
" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Lint
Plug 'w0rp/ale'
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
" Misc
Plug 'plasticboy/vim-markdown'
Plug 'cespare/vim-toml'
" Tmux
Plug 'benmills/vimux'
Plug 'spiegela/vimix'
call plug#end()

""""""""""""""""""""""
"      Settings      "
""""""""""""""""""""""
set nocompatible                " Enables us Vim specific features
filetype off                    " Reset filetype detection first ...
filetype plugin indent on       " ... and enable filetype detection
set ttyfast                     " Indicate fast terminal conn for faster redraw
set laststatus=2                " Show status line always
set encoding=utf-8              " Set default encoding to UTF-7
set autoread                    " Automatically read changed files
set autoindent                  " Enabile Autoindent
set backspace=indent,eol,start  " Makes backspace key more powerful.
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set mouse=a                     " Enable mouse mode
set noerrorbells                " No beeps
set number                      " Show line numbers
set showcmd                     " Show me what I'm typing
set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files
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
set pumheight=10                " Completion window max size
set nocursorcolumn              " Do not highlight column (speeds up highlighting)
set nocursorline                " Do not highlight cursor (speeds up highlighting)
set lazyredraw                  " Wait to redraw

" Enable to copy to clipboard for operations like yank, delete, change and put
" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
if has('unnamedplus')
  set clipboard^=unnamed
  set clipboard^=unnamedplus
endif

" This enables us to undo files even if you exit Vim.
if has('persistent_undo')
  set undofile
  set undodir=~/.cache/vim
endif

" silently execute python3: https://github.com/vim/vim/issues/3117#issuecomment-402622616
if has('python3')
  silent! python3 1
endif

" Colorscheme
syntax enable
set t_Co=256
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

""""""""""""""""""""""
"      Mappings      "
""""""""""""""""""""""

" Leader
let mapleader = ","

" Jump to next error with Ctrl-n and previous error with Ctrl-m. Close the
" quickfix window with <leader>a
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" Act like D and C
nnoremap Y y$

" Remap U to <C-r> for easier redo.
nnoremap U <C-r>

" easy system clipboard copy/paste
inoremap <C-v> <esc>"+pa
vnoremap <C-c> "+y
vnoremap <C-x> "+x

" Easier indentation
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" Remove search highlight
" nnoremap <leader><space> :nohlsearch<CR>
function! s:clear_highlight()
  let @/ = ""
  call go#guru#ClearSameIds()
endfunction
nnoremap <silent> <leader><space> :<C-u>call <SID>clear_highlight()<CR>

" Visual Mode */# from Scrooloose {{{
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>

"""""""""""""""""""""
"      Plugins      "
"""""""""""""""""""""

" airline
let airline_powerline_fonts = 1

" NerdTree
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>

let NERDTreeShowHidden=1

" ctrlp
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
  \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
  \ }

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_working_path_mode = 'ra'

" ale
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
  \ 'elixir': ['mix'],
  \ }
let g:ale_fixers = {
  \ 'go': ['gofmt', 'goimports', 'trim_whitespace', 'remove_trailing_lines'],
  \ 'elixir': ['mix_format', 'trim_whitespace', 'remove_trailing_lines'],
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

" vim-go
" No gofmt on save. We use ALE.
let g:go_fmt_autosave = 0
let g:go_fmt_experimental = 0
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>

augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

  " :GoTest
  autocmd FileType go nmap <leader>t  <Plug>(go-test)

  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)

  " :GoDoc
  autocmd FileType go nmap <Leader>d <Plug>(go-doc-vertical)

  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

  " :GoInfo
  autocmd FileType go nmap <Leader>i <Plug>(go-info)

  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split
  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)

  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

augroup elixir
  autocmd!
  autocmd Filetype elixir compiler exunit
  autocmd FileType elixir nmap <leader>b :call VimixCompile()<CR>
  autocmd FileType elixir nmap <leader>r :call VimixTestAll()<CR>
  autocmd FileType elixir nmap <leader>t :call VimixTestCurrentFile()<CR>
  autocmd FileType elixir nmap <leader>d :call alchemist#exdoc()<CR>
  autocmd FileType elixir nmap <leader>v :call alchemist#exdef()<CR>
  autocmd FileType elixir nmap <leader>s :call alchemist#exdef()<CR>

  " :ElixirAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype elixir command! -bang A call ElixirAlternate(<bang>0, 'edit')
  autocmd Filetype elixir command! -bang AV call ElixirAlternate(<bang>0, 'vsplit')
  autocmd Filetype elixir command! -bang AS call ElixirAlternate(<bang>0, 'split')
  autocmd Filetype elixir command! -bang AT call ElixirAlternate(<bang>0, 'tabe')
augroup END

function! ElixirAlternateForFile()
  if expand('%:e') == "ex"

    let test_file_name = expand('%:t:r') . "_test.exs"
    let test_file_dir = substitute(expand('%:p:h'), "/lib/", "/test/", "")
    let full_test_path = join([test_file_dir, test_file_name], "/")

    return full_test_path

  elseif match(expand('%:t'), "_test.exs") != -1

    let test_file_name = expand('%:t:r')
    let offset_amt = strlen(test_file_name) - strlen("_test")
    let module_file_name = strpart(test_file_name, 0, offset_amt) . ".ex"
    let module_file_dir = substitute(expand('%:p:h'), "/test/", "/lib/", "")
    let full_module_path = join([module_file_dir, module_file_name], "/")

    return full_module_path

  endif
endfunction

function! ElixirAlternate(bang, command)
  let alternateFile = ElixirAlternateForFile()

  if alternateFile == ""
    echoerr "can't detect alternate file"
  elseif !filereadable(alternateFile) && !a:bang
    echoerr "couldn't find file " . alternateFile
  else
    exec(":" . (a:command). " " . alternateFile)
  endif
endfunction

let g:VimuxUseNearest = 1
nmap <Leader>q :VimuxCloseRunner<CR>

" delimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_smart_quotes = 1
let g:delimitMate_expand_inside_quotes = 0
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'

autocmd VimEnter * imap <expr> <CR>
  \ pumvisible() ?
  \   (exists('v:completed_item') && !empty(v:completed_item) &&
  \     v:completed_item.word != '' && v:completed_item.kind == 'f') ?
  \       "\<C-n>\<C-y>\<CR>" :
  \       "\<C-y>" :
  \   "\<Plug>delimitMateCR\<Plug>DiscretionaryEnd"

" markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = ['go=go', 'viml=vim', 'bash=sh']
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_extensions_in_markdown = 1

" UltiSnips
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsSnippetsDir='~/.vim/UltiSnips'
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-N>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        if delimitMate#ShouldJump()
          return delimitMate#JumpMany()
        elseif strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
          return "\<Tab>"
        elseif exists('&omnifunc') && &omnifunc != ''
          return "\<C-X>\<C-O>"
        else
          return "\<C-N>"
        endif
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction

if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

function! GetAllSnippets()
  call UltiSnips#SnippetsInCurrentScope(1)
  let list = []
  for [key, info] in items(g:current_ulti_dict_info)
    let parts = split(info.location, ':')
    call add(list, {
      \"key": key,
      \"path": parts[0],
      \"linenr": parts[1],
      \"description": info.description,
      \})
    echon key ': ' info.description
    echo ''
  endfor
endfunction

command! SnippetsList :echo GetAllSnippets()

" Source a local configuration file if available.
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
