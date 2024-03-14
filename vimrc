set nocompatible
let mapleader=" "
set cursorline

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif

colo desert
highlight LineNr ctermfg=grey
highlight CursorLineNr ctermfg=grey

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping
set visualbell

" Encoding
set encoding=utf-8

" treat dash separated words as a word text object
set iskeyword+=-

" Makes popup menu smaller
set pumheight=10

" More space for displaying messages
set cmdheight=2

" Enable your mouse
set mouse=a

" Horizontal splits will automatically be below
set splitbelow

" Vertical splits will automatically be to the right
set splitright

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround
set smartindent

" Cursor motion
set scrolloff=3
set backspace=2 " backspace acts like every other program
set matchpairs+=<:> " use % to jump between pairs

" Cursor shape
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Move up/down editor lines
nnoremap <silent> j gj
nnoremap <silent> k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Faster completion
set updatetime=300

" By default timeoutlen is 1000 ms
set timeoutlen=500

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd
set wildmenu

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set shortmess-=S

" Visualize tabs and newlines set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <silent> <leader>l :set list!<CR> " Toggle tabs and EOL


" ===== remappings =====
" easier escape
inoremap <silent> jj <Esc>
" clear highlighted words
nnoremap <silent> <Esc><Esc> :noh<return>
" Remove all trailing whitespace by pressing F5
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
" Better window navigation
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l
" Alternate way to save
nnoremap <silent> <C-s> <cmd>w<CR>

