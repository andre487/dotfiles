" Config encoding
scriptencoding utf-8
set encoding=utf-8
set nocompatible

" General
set ttyfast
set nobackup
set noswapfile

set laststatus=2
set statusline=%F%m%r%h%w\ [TP=%Y]\ [LEN=%L]\[ENC=%{&encoding}]\[FMT=%{&ff}]\ [POS=%03l,%03v][%p%%]
set clipboard+=unnamed

set exrc secure
set autoread

" Display
set title
set novisualbell
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Text format 
set fileformats=unix,dos,mac
set fileencodings=utf-8,ucs-2,cp1251,cp866,koi8-r

set backspace=indent,eol,start

set scrolloff=3
set sidescroll=5
set sidescrolloff=5
set nowrap

set spelllang=en,ru 

" Indents 
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

set autoindent
set smartindent
set cindent

set shiftround
set paste

" Highlight
syntax on
colorscheme elflord 
set lazyredraw

" Code
set completeopt=menu,preview
set infercase
set wrap
set showmatch
set matchpairs+=<:>

" Search
set smartcase
set incsearch
set hlsearch
set gdefault
