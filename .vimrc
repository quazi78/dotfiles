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

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

"This will add vimplug if it is not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'hashivim/vim-terraform'
Plug 'ekalinin/dockerfile.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'kien/ctrlp.vim'
Plug 'altercation/vim-colors-solarized'

call plug#end()

map <C-o> :NERDTreeToggle<CR>
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprev<CR>

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme='understated'
let g:airline_powerline_fonts = 1

silent! set bg=dark
silent! colorscheme solarized


" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"Allows you to use Silver Searcher to search the project directory for the
"word under the cursor by hitting K
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap ; :
