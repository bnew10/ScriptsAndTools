" ===== Vundle =====
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'PeterRincker/vim-searchlight'
Plugin 'osyo-manga/vim-anzu'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'pangloss/vim-javascript'
Plugin 'crusoexia/vim-javascript-lib'
Plugin 'elzr/vim-json'
Plugin 'mxw/vim-jsx'
Plugin 'sheerun/vim-polyglot'
Plugin 'jremmen/vim-ripgrep'
Plugin 'tpope/vim-commentary'
Plugin 'crusoexia/vim-monokai'
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" ===== remappings =====
" easier escape
inoremap jj <Esc>
" clear highlighted words
nnoremap <Esc><Esc> :noh<return>
"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>


" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=2 " backspace acts like every other program
set matchpairs+=<:> " use % to jump between pairs

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL


" ===== netrw =====
" Remove banner from top of netrw
let g:netrw_banner = 0


" ===== syntax highlighting =====
syntax on
colorscheme monokai
set termguicolors
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1


" ===== vim-airline =====
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'


" ===== ctrlp =====
let g:ctrlp_match_window = 'max:40,results:80'
" ===== ctrlp-funky =====
nnoremap <Leader>fu :CtrlPFunky<Cr>


" ===== fzf =====
set rtp+=/usr/local/opt/fzf
nnoremap <Leader>fz :FZF<Cr>


" ===== ripgrep =====
let g:rg_command = 'rg --column --line-number --no-heading --fixed-strings --smart-case --no-ignore --hidden --follow --color "always" -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"-g "!{.git,node_modules,vendor}/*" '


"let g:rg_command = 'rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
