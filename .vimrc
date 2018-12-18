set number
set relativenumber
syntax on
filetype plugin indent on
set hlsearch
set ic
set noshowmode
set laststatus=2
set showtabline=2
set hidden

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'hashivim/vim-terraform'
Plug 'ekalinin/dockerfile.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'kien/ctrlp.vim'

call plug#end()

map <C-o> :NERDTreeToggle<CR>
:nnoremap <Tab> :bnext<CR>

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

silent! colorscheme seoul256
