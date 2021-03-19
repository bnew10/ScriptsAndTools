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
Plugin 'troydm/zoomwintab.vim'
Plugin 'machakann/vim-sandwich'
Plugin 'farmergreg/vim-lastplace'
Plugin 'liuchengxu/vista.vim'
Plugin 'neoclide/coc.nvim'
Plugin 'kevinoid/vim-jsonc'
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

let g:airline#extensions#zoomwintab#enabled = 1
nmap <Leader>z <C-w>o


" ===== ctrlp =====
let g:ctrlp_match_window = 'max:40,results:80'
" ===== ctrlp-funky =====
nnoremap <Leader>fu :CtrlPFunky<Cr>
" ===== ctrlp-tag =====
nnoremap <Leader>ta :CtrlPTag<Cr>


" ===== fzf =====
set rtp+=/usr/local/opt/fzf
nnoremap <Leader>fz :FZF<Cr>


" ===== ripgrep =====
let g:rg_command = 'rg --column --line-number --no-heading --fixed-strings --smart-case --no-ignore --hidden --follow --color "always" -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"-g "!{.git,node_modules,vendor}/*" '


"let g:rg_command = 'rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'

" ===== git-blame =====
nnoremap <Leader>gb :<C-u>call gitblame#echo()<CR>

" ===== coc.nvim =====
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Shortcut for showing lint output
nnoremap <leader>lo :CocCommand workspace.showOutput<cr>

" ===== Vista =====
nnoremap <silent> <leader>[ :Vista!!<cr>
