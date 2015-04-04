" Config encoding
scriptencoding utf-8
set encoding=utf-8
set nocompatible

" General
set ttyfast
set nobackup
set noswapfile

set laststatus=2
set statusline=%t\ (%Y)%m%r%h%w\ [LEN=%L]\ [ENC=%{&encoding}]\[FMT=%{&ff}]\ [POS=%03l,%03v][%p%%]
set clipboard+=unnamed

set exrc secure
set autoread

" Display
set t_Co=256
set title
set novisualbell

set nowrap
set scrolloff=3
set sidescroll=5
set sidescrolloff=5

set nostartofline
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Text format 
set termencoding=utf-8
set fileformats=unix,dos,mac
set fileencodings=utf-8,ucs-2,cp1251,cp866,koi8-r

set backspace=indent,eol,start
set textwidth=120
set spelllang=en,ru 
set noeol

" Indents 
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

set autoindent
set smartindent
set cindent

set shiftround
set pastetoggle=<leader>p

" Highlight
syntax on
set background=dark
set lazyredraw

" Code
set completeopt=menu,preview
set infercase
set wrap
set showmatch
set matchpairs+=<:>
set wildmenu
set wildcharm=<TAB>

" Search
set smartcase
set incsearch
set hlsearch
set gdefault

" Diff
set diffopt=filler
set diffopt+=horizontal
set diffopt+=iwhite

