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
Plug 'https://github.com/vim-syntastic/syntastic'
Plug 'airblade/vim-gitgutter'

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
"set expandtab
set tabstop=4
set wildmenu
set wildmode=full
set textwidth=80
set si " Smart indent
set wrap

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

" [plugin settings]

" [snipmate] 
imap <tab> <Plug>snipMateNextOrTrigger
smap <tab> <Plug>snipMateNextOrTrigger

" [vim-surround]
" yss{surround}
"
" [t_comment]
" gcc in select or visual mode
"
" [syntastic]
" NOTE: to get syntantic to be fully supported for python and not throw
" errors be sure to setup all the necessary shims in pyenv
" NOTE: may have to run $ sudo chmod ugo-x /usr/libexec/path_helper if $PATH 
" in vim != $PATH in whatever shell you're using (only affects osx)
" TODO: automate this shit ^^
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers=['flake8', 'python3']



