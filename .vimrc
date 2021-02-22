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
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" utils
Plugin 'VundleVim/Vundle.vim'      " Vundle bundler, https://github.com/VundleVim/Vundle.vim
Plugin 'vim-scripts/IndexedSearch' " Better search message, https://github.com/vim-scripts/IndexedSearch

" files
Plugin 'preservim/nerdtree'            " Files tree at left, https://github.com/preservim/nerdtree
Plugin 'jeetsukumaran/vim-buffergator' " Work with buffers as tabs, https://github.com/jeetsukumaran/vim-buffergator

" text
Plugin 'bronson/vim-trailing-whitespace' " Highlight trailing whitespaces, https://github.com/bronson/vim-trailing-whitespace
Plugin 'mayton/bunin.vim'                " Edit bundle strings in buffer (for example borschik:include), https://github.com/mayton/bunin.vim

" syntax
Plugin 'HerringtonDarkholme/yats.vim' " TypeScript, https://github.com/HerringtonDarkholme/yats.vim
Plugin 'tpope/vim-commentary'         " Comment command, https://github.com/tpope/vim-commentary

call vundle#end()
filetype plugin indent on

" Config encoding
scriptencoding utf-8
set encoding=utf-8

" General
set ttyfast
set nobackup
set noswapfile
set shell=/bin/bash

set exrc secure
set autoread

set undofile
set undodir=~/.vimundo/

set hidden
set history=1000

set autoread
set re=0

" Display
set t_Co=256
set t_ut=
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
" recommended: default, desert, torte, pablo, koehler, murphy
color default
map <F11> :color desert<CR>

" Status
set laststatus=2
set statusline=[%n]\ %t\ \|\ %Y\ %{&encoding}\ %{&ff}\ \|\ Len\ %L\ \|\ Pos\ %03l:%03v\ %p%%\ %=%<%F\ %m%r%h%q%w
highlight StatusLine ctermfg=lightgray ctermbg=black

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

" Commands
" reload .vimrc
map <F12> :so $MYVIMRC<CR>

" NERDTree
map <F2> :NERDTreeToggle<CR>
map <F3> :BuffergatorToggle<CR>
let NERDTreeShowHidden=1

" Bunin
map <C-B> :BuninEdit<CR>

" Enable .vimrc.extra
if has("user_commands")
  let vimrc_extra=expand('~/.vimrc.extra')
  if filereadable(vimrc_extra)
      execute 'source '.vimrc_extra
  endif
endif
