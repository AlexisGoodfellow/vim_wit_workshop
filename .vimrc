execute pathogen#infect()
filetype plugin indent on
let mapleader = ","
set timeout timeoutlen=8000
syntax on
set number nu
set visualbell
set autoindent
set smartindent
set encoding=utf-8
set expandtab
set ruler
set nocompatible
set tabstop=4
set smarttab
set shiftwidth=4
set mouse=n
set ttymouse=xterm2
set updatetime=100
set foldmethod=indent
set incsearch
set hlsearch
" <Leader> key is ','
set iskeyword+=\

augroup PHP
    autocmd!
    autocmd FileType php inoremap <Leader>tu <Esc>:call Test("unit")<CR>:execute "Sexe " . g:test_cmd<CR>
    autocmd FileType php noremap <Leader>tu :call Test("unit")<CR>:execute "Sexe " . g:test_cmd<CR>
    autocmd FileType php inoremap <Leader>td <Esc>:call Test("db_unit")<CR>:execute "Sexe " . g:test_cmd<CR>
    autocmd FileType php noremap <Leader>td :call Test("db_unit")<CR>:execute "Sexe " . g:test_cmd<CR>
    autocmd FileType php inoremap <Leader>ti <Esc>:call Test("integration")<CR>:execute "Sexe " . g:test_cmd<CR>
    autocmd FileType php noremap <Leader>ti :call Test("integration")<CR>:execute "Sexe " . g:test_cmd<CR>
    autocmd FileType php inoremap <Leader>tc <Esc>:call Test("codeception")<CR>:execute "Sexe " . g:test_cmd<CR>
    autocmd FileType php noremap <Leader>tc :call Test("codeception")<CR>:execute "Sexe " . g:test_cmd<CR>
    " -2 == de-coupled
    autocmd FileType php inoremap <Leader>t-2 <Esc>:call Test("decoupled")<CR>:execute "Sexe " . g:test_cmd<CR>
    autocmd FileType php noremap <Leader>t-2 :call Test("decoupled")<CR>:execute "Sexe " . g:test_cmd<CR>
    autocmd BufWritePost {*.php} echom system("php -l ".expand('%'))
    autocmd BufWritePost {*.php} execute "Sexe wf format; wf sniff; wf analyze"
augroup END
" Ack -> Ag
if executable('ag')
    let g:ackprg = 'ag -r --vimgrep'
    let g:searchpath = '~/codebase/php'
endif
" PHP Find Implementations
function! PhpImplementations(word)
    exe 'Ack "implements.*' . a:word . ' *($|{)" ' . g:searchpath
endfunction

" PHP Find Subclasses
function! PhpSubclasses(word)
    exe 'Ack "extends.*' . a:word . ' *($|{)" ' . g:searchpath
endfunction

" PHP Find Usage
function! PhpUsage(word)
    exe 'Ack "::' . a:word . '\(|>' . a:word . '\(" ' . g:searchpath
endfunction

" Working with tag files
noremap <Leader>ji <C-w>]
noremap <Leader>jo <C-t>
" Working with ag/vimgrep
noremap <Leader>fi :call PhpImplementations('<cword>')<CR>
noremap <Leader>fs :call PhpSubclasses('<cword>')<CR>
noremap <Leader>fu :call PhpUsage('<cword>')<CR>
autocmd QuickFixCmdPost [^l]* nested cwindow
" Hop from gitgutter hunk to hunk
nmap <Leader>v :GitGutterNextHunk<CR>
nmap <Leader>b :GitGutterPrevHunk<CR>
" Database connectivity
nmap <Leader>qq :DB <CONNECTION_STRING>
" Change every '/' in a file path to '\'.
vmap <Leader>\ :s/\//\\/g<CR>
" NERDTree
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
map <Leader>tt :NERDTreeToggle<CR>
" NERDTree filetype highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
" Syntastic options
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_php_checkers = ["php", "phplint", "phpmd", "phpstan"]

" Vim-arline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#ale#enabled = 1
" Sensible window navigation
map <Leader>jj :wincmd j<CR>
map <Leader>kk :wincmd k<CR>
map <Leader>hh :wincmd h<CR>
map <Leader>ll :wincmd l<CR>
map - <C-w>-
map + <C-w>+
map <Leader>z :!find . -name
" Disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
" Trim trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e
" Autocomplete
imap <Leader>c <C-x><C-O>
" Importing Classes
function! IPhpInsertUse()
  call PhpInsertUse()
  call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
" Reset the omnifunction to something else to make it faster
autocmd FileType php setlocal omnifunc=phpcomplete_extended#CompletePHP
" Extending Class Names to be Fully Qualified
function! IPhpExpandClass()
  call PhpExpandClass()
  call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <Leader>e <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>
" Sort namespace declarations
let g:php_namespace_sort_after_insert = 1
" VDebug
let g:vdebug_options = {
    \    'port' : 9000,
    \    'timeout' : 20,
    \    'server' : '127.0.0.1',
    \    'on_close' : 'stop',
    \    'break_on_open' : 0,
    \    'ide_key' : 'PHPSTORM',
    \    'debug_window_level' : 0,
    \    'debug_file_level' : 0,
    \    'debug_file' : '',
    \    'path_maps' : {'/wayfair/data/codebase/php' : '/Users/<REDACTED>/codebase/php'},
    \    'watch_window_style' : 'expanded',
    \    'marker_default' : '⬦',
    \    'marker_closed_tree' : '▸',
    \    'marker_open_tree' : '▾',
    \    'sign_breakpoint' : '▷',
    \    'sign_current' : '▶',
    \    'continuous_mode'  : 1
    \}
" Set Javascript to use sane indenting
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
" For hitting endpoints with cURL
let endpoint = 'http://www.google.com'
map <Leader>hg :HttpGet <C-R>=endpoint<CR>
map <Leader>hpu :HttpPut <C-R>=endpoint<CR>
map <Leader>hpo :HttpPost <C-R>=endpoint<CR>
map <Leader>hd :HttpDelete <C-R>=endpoint<CR>
" Gutentags options
let g:gutentags_cache_dir = '~/.vim/gutentags'
" fzf fuzzy finder - it's ctrlP, but faster
nnoremap <C-p> :Files<Cr>
" phpunit testing
function! Test(type)
  let g:test_path = split(expand('%:p'), 'php/')[-1]
  let g:test_cmd = 'wf test ' . a:type . ' -x 1 -t ' . g:test_path
  return g:test_cmd
endfunction

" GraphQL Syntax highlighting
let g:graphql_javascript_tags = ['gql', 'graphql', 'qql', 'Relay.QL']
" YCM options
let g:ycm_semantic_triggers = {'php' : ['->', '::']}
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_complete_in_comments = 1
let g:ycm_min_num_of_chars_for_completion = 2
" NERDCommenter settings
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = { 'php': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
" Set ALE omnifunc
set omnifunc=ale#completion#OmniFunc
" Pythonisms
augroup PYTHON
    autocmd!
    autocmd BufWritePost {*.py} execute "Black"
augroup END
let g:pymode_python = 'python3'
let g:black_linelength = 80
let g:python_highlight_all = 1
let g:syntastic_python_checkers = ["pydocstyle"]
" Have syntastic help with yaml
let g:syntastic_yaml_checkers = ['yamllint']
