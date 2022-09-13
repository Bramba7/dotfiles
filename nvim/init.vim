" *** General ***

syntax on
filetype plugin indent on
set encoding=UTF-8
set autoindent
set smarttab
set expandtab
set number
set relativenumber
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set mouse=a
set hidden
set nowrap
set noswapfile
set nobackup
set incsearch
set signcolumn=yes
set undodir=~/.vim/undodir
set undofile
set paste
set clipboard=unnamedplus
set noerrorbells
set scrolloff=10

" *** Airline Config ***

let g:airline#extensions#whitespace#enabled = 0 "remove Trailing white space
let g:airline_section_z = "%p%% \uf0c9 %l/%L" 

" *** Plugins ***

call plug#begin()

Plug 'preservim/nerdtree' " NerdTree
Plug 'tpope/vim-commentary' "Commenting gcc and gc
Plug 'vim-airline/vim-airline' "Status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-markdown' 
Plug 'airblade/vim-gitgutter'
Plug 'rafi/awesome-vim-colorschemes' "Theme
Plug 'ryanoasis/vim-devicons' "Icons
Plug 'preservim/tagbar'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'morhetz/gruvbox'

call plug#end()

" *** Some shortcuts ***


nnoremap Q <nop>
"noremap <C-S> :so %<CR>
noremap <C-s> :w <CR>
noremap <C-t> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>


" *** ColorScheme ***

" colorscheme sierra 
" colorscheme alduin
" colorscheme anderson
" colorscheme jellybeans
" colorscheme space-vim-dark
" colorscheme deus
" colorscheme sonokai
" colorscheme iceberg   
colorscheme gruvbox
let g:airline_theme='tomorrow'
