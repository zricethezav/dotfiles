" File: .vimrc
" Author: zrice
" Description: vim config
" Last Modified: July 04, 2017

set shell=zsh


" [vim-plug]
call plug#begin()


" [define plugins]
Plug 'scrooloose/nerdtree'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'https://github.com/vim-scripts/tComment'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'w0rp/ale'
Plug 'https://github.com/majutsushi/tagbar'

call plug#end()

filetype plugin indent on
filetype plugin on
syntax enable

" [statusline]
set statusline=%F%m%r%h%w\ %y\ [\ A(%03.3b)\ .\:.\ H(%02.2B)\ .\:.\ L%04l\ -\ 
        \C%04v\ .\:.\ %p%%\ .\:.\ %L\ Length\ ]
set laststatus=2

" [basic settings]
set clipboard=unnamed
set number
set encoding=utf-8
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do,for,switch,case
set backspace=indent,eol,start
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set wildmenu
set wildmode=full
set textwidth=80
set si " Smart indent
set wrap
set autowrite

" [cursor]
let &t_ti.="\<Esc>[1 q"
let &t_SI.="\<Esc>[5 q"
let &t_EI.="\<Esc>[1 q"
let &t_te.="\<Esc>[0 q"

" [spelling]
" usage :set spell, :set nospell
nmap <silent> <leader>s :set spell!<CR>
set spelllang=en_us

" [whitespace linter]
" usage :set list, :set nolist
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
let g:go_highlight_trailing_whitespace_error=0

" [delete whitespace on save]
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" [last edit position on open]
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" [plugin settings]
" [snipmate] 
imap <tab> <Plug>snipMateNextOrTrigger
smap <tab> <Plug>snipMateNextOrTrigger
let g:snips_email="zach@agrible.com"
let g:snips_name="zach"
let g:snips_github="github.com/aginfo"

" [vim-surround]
" yss{surround}

" [t_comment]
" gcc in select or visual mode

" [lightline & ALE]
set t_Co=256
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'lineinfo'],
      \             [ 'percent'],
      \             [ 'readonly', 'filename', 'modified', 'charvaluehex' ],
      \             [ 'linter_warnings', 'linter_errors', 'linter_ok' ],
      \             [ 'fileformat', 'fileencoding', 'filetype' ] ],
      \ },
      \ 'component_expand': {
      \   'linter_warnings': 'LightlineLinterWarnings',
      \   'linter_errors': 'LightlineLinterErrors',
      \   'linter_ok': 'LightlineLinterOK'
      \ },
      \ 'component_type': {
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'ok'
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ },
      \ }
autocmd User ALELint call lightline#update()
function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d >>', all_errors)
endfunction
function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓' : ''
endfunction
" [ALE navigation]
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


" [vim-go]
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>f  <Plug>(go-test-func)
let g:go_list_type = "quickfix"


" [Searching]
nmap ; :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>g :Ag<CR>
nmap <Leader>gg :Ag!<CR>
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" [NerdTree]
let NERDTreeIgnore = ['\.pyc$']

" [Tagbar]
nnoremap <silent> <Leader>tb :TagbarToggle<CR>
