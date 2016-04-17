set encoding=utf-8

if has('unix')
  let plugpath='~/.config/nvim/autoload/plug.vim'
  let path='~/.config/nvim/plugged/'
endif
if empty(glob(plugpath))
  " Initial bootstrapping on first install
  execute 'silent !curl -fLo ' . plugpath . ' --create-dirs ' .
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall
endif


" Plugins
call plug#begin(path)
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'w0ng/vim-hybrid'
Plug 'benekastah/neomake'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'carlitux/deoplete-ternjs'
Plug 'uarun/vim-protobuf'
Plug 'solarnz/thrift.vim'
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/syntastic'
Plug 'derekwyatt/vim-scala', { 'for' : 'scala' }
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir'}
Plug 'slashmili/alchemist.vim', { 'for': 'elixir'}
Plug 'pangloss/vim-javascript', { 'for': 'javascript'}
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'mxw/vim-jsx', { 'for': 'jsx'}
call plug#end()

map <C-c> :NERDTreeToggle<CR>
map <C-b> :TagbarToggle<CR>

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

syntax enable
set ffs=unix
set t_Co=256
set background=dark
colorscheme hybrid
let g:airline_theme='term'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
filetype plugin on
filetype indent on
set mouse=nh

map <F5> :setlocal spell! spelllang=en_us<CR>

" Filetype settings {{{
autocmd FileType python set shiftwidth=4
autocmd FileType python set softtabstop=4
autocmd FileType python set expandtab

autocmd FileType ruby set tabstop=2
autocmd FileType ruby set expandtab
autocmd FileType ruby set softtabstop=2
autocmd FileType ruby set shiftwidth=2

autocmd FileType elixir set tabstop=2
autocmd FileType elixir set expandtab
autocmd FileType elixir set softtabstop=2
autocmd FileType elixir set shiftwidth=2

autocmd FileType scss,css set tabstop=2
autocmd FileType scss,css set expandtab
autocmd FileType scss,css set softtabstop=2
autocmd FileType scss,css set shiftwidth=2

autocmd FileType vim set tabstop=2
autocmd FileType vim set expandtab
autocmd FileType vim set softtabstop=2
autocmd FileType vim set shiftwidth=2

autocmd FileType javascript set tabstop=2
autocmd FileType javascript set expandtab
autocmd FileType javascript set softtabstop=2
autocmd FileType javascript set shiftwidth=2
" }}}

" react {{{
let g:syntastic_javascript_checkers = ['eslint']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }}}

" remove whitespace
nnoremap <Leader>rws :%s/\s\+$//e<CR>

" Close Vim if NERDTree is the last thing open {{{
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Automatically jump to where you were when you closed the file upon
" re-opening it {{{
autocmd BufReadPost *
 \ if expand("<afile>:p:h") !=? $TEMP |
 \ if line("'\"") > 1 && line("'\"") <= line("$") |
 \ let JumpCursorOnEdit_foo = line("'\"") |
 \ let b:doopenfold = 1 |
 \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
 \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
 \ let b:doopenfold = 2 |
 \ endif |
 \ exe JumpCursorOnEdit_foo |
 \ endif |
 \ endif |
 \ autocmd BufWinEnter *
 \ if exists("b:doopenfold") |
 \ exe "normal zv" |
 \ if(b:doopenfold > 1) |
 \ exe "+".1 |
 \ endif |
 \ unlet b:doopenfold |
 \ endif
" }}}

" custom mappings
tnoremap <Esc> <C-\><C-n>
nnoremap <Leader>w :w <CR>

set laststatus=2
set noshowmode
set shortmess=atI
set showcmd

set hidden
set autoread
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git \ls-files -oc --exclude-standard']

set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoindent

set list
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮

set iskeyword-=_
set incsearch
let mapleader = ','
set scrolloff=3
set ignorecase
set smartcase
set backspace=indent,eol,start
set whichwrap=h,l,b,<,>,~,[,]

set relativenumber

map <silent> <leader>V :source ~/.config/nvim/init.vim<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

command! W  write

inoremap jj <esc>
inoremap jk <esc>

map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

nnoremap <S-Tab> :bprevious<CR>
nnoremap <Tab> :bnext<CR>

nnoremap <Leader>rws :%s/\s\+$//e<CR>


