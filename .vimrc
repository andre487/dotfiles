" Plugins (Vundle)
if has("user_commands")
  " Setting up Vundle - the vim plugin bundler
  let VundleInstalled=0
  let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
  if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim
    let VundleInstalled=1
  endif
endif

filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'             " Vundle bundler
Plugin 'scrooloose/nerdtree'              " Files tree at left
Plugin 'jistr/vim-nerdtree-tabs'          " Some fixes for tabs
Plugin 'YankRing.vim'                     " Copy-paste with suitable history
Plugin 'kien/ctrlp.vim'                   " Fuzzy search for files
Plugin 'sudo.vim'                         " Open file with sudo
Plugin 'bronson/vim-trailing-whitespace'  " Highlight trailing whitespaces
Plugin 'godlygeek/tabular'                " Aligning tables
Plugin 'tpope/vim-markdown'               " Better markdown
Plugin 'zhaocai/GoldenView.Vim'           " Golden ratio for splits

call vundle#end()
filetype plugin indent on

" Config encoding
scriptencoding utf-8
set encoding=utf-8

" General
set nocompatible
set ttyfast
set nobackup
set noswapfile
set shell=$SHELL

set laststatus=2
set statusline=%t\ (%Y)%m%r%h%w\ [LEN=%L]\ [ENC=%{&encoding}]\[FMT=%{&ff}]\ [POS=%03l,%03v][%p%%]
set clipboard+=unnamed

set exrc secure
set autoread

set undofile
set undodir=~/.vimundo/

set hidden
set history=1000

set autoread

" Display
set t_Co=256
set title
set novisualbell

set nowrap
set scrolloff=3
set sidescroll=5
set sidescrolloff=5

set showcmd

set nostartofline
if has("autocmd")
  " Remember last position in file
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Highlight
syntax on
set lazyredraw

" Colors
set background=dark

" Text format
set termencoding=utf-8
set fileformats=unix,dos,mac
set fileencoding=utf-8
set fileencodings=utf-8,ucs-2,cp1251,cp866,koi8-r

set backspace=indent,eol,start
set textwidth=0
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
set pastetoggle=<leader>p

" Code
set completeopt=menu,preview
set infercase
set showmatch
set matchpairs+=<:>
set wildmenu
set wildcharm=<TAB>

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch
set gdefault

" Diff
set diffopt=filler
set diffopt+=horizontal
set diffopt+=iwhite

" NERDTree
map <F2> :NERDTreeToggle<CR>

" YankRing
let g:yankring_history_dir = $HOME.'/.vim/'
let g:yankring_history_file = '.yankring_history'

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" GoldenView
let g:goldenview__enable_default_mapping=0
